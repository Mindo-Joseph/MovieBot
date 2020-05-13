#!/usr/bin/env ruby

require 'telegram/bot'
require './token.rb'
require './lib/movie_api.rb'
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
      movie = Movies.new
      code = movie.genre_code("action")
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        image = movie.generate_poster_link(k)
        text_array = movie.fetch_movie_details(k)
        trailer = movie.generate_youtube_link(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: image )
        bot.api.send_message(chat_id: message.chat.id, text: "Rating %s \nTitle %s \nOverview: %s \nRelease Date %s" %text_array)
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{trailer}")


      end
      
      
      
      
    end
  end
end
