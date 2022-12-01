#!/usr/bin/env ruby
require 'bunny'
require 'dotenv'
Dotenv.load('vars.env')

connection = Bunny.new(ENV['CONN'])
connection.start

channel = connection.create_channel
queue = channel.queue('hello')

begin
  puts ' [*] Waiting for messages. To exit press CTRL+C'
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    puts " [x] Received #{body}, working..."
    sleep rand(5)
  end
rescue Interrupt => _e
  connection.close
  exit(0)
end
