#!/usr/bin/env ruby
require 'bunny'
require 'dotenv'
Dotenv.load('vars.env')

connection = Bunny.new(ENV['CONN'])
connection.start

channel = connection.create_channel
queue = channel.queue('hello')

10.times do |x|
  channel.default_exchange.publish("Hello World! #{x}", routing_key: queue.name)
  puts " [x] Sent 'Hello World #{x}!'"
end

connection.close
