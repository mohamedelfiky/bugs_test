class BugsWorker
  include Sneakers::Worker
  from_queue 'bugs', env: nil

  def work(bug_redis_key)
    Sneakers.logger.info "handling #{ '#' * 7 } #{ bug_redis_key } #{ '#' * 7 }"

    params = Redis.current.get(bug_redis_key)
    unless params.nil?
      Bug.create!(JSON.parse(params))
      # delete bug from redis after saving it to db
      Redis.current.del(bug_redis_key)
    end

    ack! # message was received
  end
end
