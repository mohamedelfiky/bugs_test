Redis.current = Redis::Namespace.new('instabug_cache', redis: Redis.new)
