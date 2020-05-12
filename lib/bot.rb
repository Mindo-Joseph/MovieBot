# frozen_string_literal: true

require 'telegram/bot'
token = '1071576461:AAH4gh_4fpKgaeTWt9dZE2PEzwQNif9p-KA'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    end
  end
end
