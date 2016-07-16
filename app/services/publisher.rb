class Publisher
  def self.publish(exchange, message)
    exchange = channel.fanout("instabug.#{ exchange }")
    exchange.publish(message)
  end

  def self.channel
    @channel ||= connection.create_channel
  end

  def self.connection
    @connection ||= Bunny.new.tap(&:start)
  end
end
