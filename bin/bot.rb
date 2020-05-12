#!/usr/bin/env ruby

require 'telegram/bot'
require './token.rb'
token = $token

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
      bot.api.send_message(chat_id: message.chat.id, text: 'Welcome, I am here to give you movie recommendations')
      bot.api.send_message(chat_id: message.chat.id, text: "
        Type on one of the following commands for the genre you want \n /action for action movies \n /comedy for comedy \n /romance for romance \n or /stop to end this session  ")

    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}, hope to hear from you soon ")

    when '/action'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get what might interest you')
    end
  end
end
