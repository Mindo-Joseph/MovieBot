# frozen_string_literal: true

require 'telegram/bot'
require './token.rb'
token = $token

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
      bot.api.send_message(chat_id: message.chat.id, text: "Which films are u interested In?")
      
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    
    when '/action'
      bot.api.send_message(chat_id: message.chat.id, text: "Action films ")
    end

  end
end
