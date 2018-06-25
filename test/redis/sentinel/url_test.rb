require "test_helper"

class Redis::Sentinel::UrlTest < Minitest::Test
  def test_handles_empty_options
    Redis.new
  end

  def test_parses_default_env_with_empty_options
    ENV['REDIS_URL'] = 'redis+sentinel://redis-sentinel.svc.cluster.local:26380/mymaster'

    redis = Redis.new
    assert_equal 'redis://mymaster', redis._client.options[:url]
    assert_equal [{ host: 'redis-sentinel.svc.cluster.local', port: 26380 }], redis._client.options[:sentinels]

    ENV.delete('REDIS_URL')
  end

  def test_passes_through_redis_urls
    redis = Redis.new(url: 'redis://localhost')
    assert_equal 'redis://localhost', redis._client.options[:url]
    assert_nil redis._client.options[:sentinels]
  end

  def test_passes_through_unknown_urls
    assert_raises(ArgumentError) { Redis.new(url: 'redis+junk://localhost') }
  end

  def test_parses_redis_sentinel_urls
    redis = Redis.new(url: 'redis+sentinel://redis-sentinel.svc.cluster.local:26380/mymaster/3')
    assert_equal 'redis://mymaster', redis._client.options[:url]
    assert_equal [{ host: 'redis-sentinel.svc.cluster.local', port: 26380 }], redis._client.options[:sentinels]
    assert_equal 3, redis._client.options[:db]
  end

  def test_defaults_sentinel_port
    redis = Redis.new(url: 'redis+sentinel://redis-sentinel.svc.cluster.local')
    assert_equal [{ host: 'redis-sentinel.svc.cluster.local', port: 26379 }], redis._client.options[:sentinels]
  end

  def test_defaults_service_name
    redis = Redis.new(url: 'redis+sentinel://redis-sentinel.svc.cluster.local')
    assert_equal 'redis://mymaster', redis._client.options[:url]
  end
end
