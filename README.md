# Redis Sentinel URL

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redis-sentinel-url'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redis-sentinel-url

## Usage

Once the code is `require`d (which happens automatically if you are using bundler) you can use the following URL syntax in the `REDIS_URL` environment variable, or passed to `Redis.new(url: ...)`:

`redis+sentinel://host[:port][/service_name[/db]][?param1=value1[&param2=value=2&...]]`

This syntax is based on the syntax from https://github.com/exponea/redis-sentinel-url but does not support multiple sentinel hosts or passing passwords.

The service name defaults to 'mymaster' and the sentinel port defaults to 26379. There is no default database number set by this library, the parameter is only passed to redis if it set.

Note: You don't need to manually call any of the library code, Redis is patched to handle the sentinel URL syntax automatically when the library is required.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/clearbit/redis-sentinel-url.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
