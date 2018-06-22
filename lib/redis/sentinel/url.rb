require "redis"
require "redis/sentinel/url/version"

class Redis
  module Sentinel
    class URL
      DEFAULT_SENTINEL_PORT    = 26379
      DEFAULT_SENTINEL_SERVICE = 'mymaster'

      attr_reader :uri

      def self.parse(url)
        new(url).parse
      end

      def initialize(url)
        @uri = URI(url)
      end

      # [/service_name[/db]]
      def path_options
        path_parts = uri.path.split('/')
        case path_parts.length
        when 3
          { service_name: path_parts[1], db: path_parts[2] }
        when 2
          { service_name: path_parts[1] }
        else
          {}
        end
      end

      def query_options
        CGI::parse(uri.query.to_s).transform_keys(&:to_sym)
      end

      def parse
        uri_options  = path_options.merge(query_options)
        service_name = uri_options.delete(:service_name) || DEFAULT_SENTINEL_SERVICE

        uri_options[:url]       = "redis://#{service_name}"
        uri_options[:sentinels] = [{ host: uri.host, port: uri.port || DEFAULT_SENTINEL_PORT }]

        uri_options
      end
    end

    module OptionParser
      def _parse_options(options)
        return options if options[:_parsed]

        default_url = ::Redis::Client::DEFAULTS[:url]
        default_url = default_url.call if default_url.respond_to?(:call)

        url = options[:url] || default_url
        if url.to_s.start_with?('redis+sentinel://')
          options = options.merge(Redis::Sentinel::URL.parse(url))
        end

        super(options)
      end
    end
  end
end

class ::Redis::Client
  prepend Redis::Sentinel::OptionParser
end
