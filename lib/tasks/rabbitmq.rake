namespace :rabbitmq do
  desc 'Setup rabbitMQ routing'
  task setup: :environment do
    require 'bunny'

    conn = Bunny.new
    conn.start

    ch = conn.create_channel
    ch.fanout('instabug.bugs')

    # get or create queue (note the durable setting)
    ch.queue('bugs', durable: true).bind('instabug.bugs')

    conn.close
  end
end
