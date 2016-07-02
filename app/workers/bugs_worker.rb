class BugsWorker
  include Sidekiq::Worker

  # :nocov:
  def perform(bug_redis_key)
    params = Redis.current.get(bug_redis_key)
    unless params.nil?
      Bug.create!(JSON.parse(params))
      # delete bug from redis after saving it to db
      Redis.current.del(bug_redis_key)
    end
  end
  # :nocov:
end
