# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "redis/sentinel/url/version"

Gem::Specification.new do |spec|
  spec.name          = "redis-sentinel-url"
  spec.version       = Redis::Sentinel::Url::VERSION
  spec.authors       = ["Rob Holland"]
  spec.email         = ["rob@clearbit.com"]

  spec.summary       = %q{Adds support for configuring sentinel mode via REDIS_URL to redis-rb}
  spec.description   = %q{Adds support for configuring sentinel mode via REDIS_URL to redis-rb}
  spec.homepage      = "http://github.com/clearbit/redis-sentinel-url"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_dependency "redis", "> 3.2.1"
end
