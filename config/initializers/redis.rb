Redis.current = Redis::Namespace.new("instabug_cache:#{ Rails.env }", redis: Redis.new)
