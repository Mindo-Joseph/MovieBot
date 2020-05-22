#!/usr/bin/env ruby
require 'telegram/bot'
require_relative '../keys.rb'
require_relative '../lib/movie_api.rb'
# rubocop:disable Layout/LineLength

def greet(item, message)
  item.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
end

def post_photo(bot_instance, message, photo)
  bot_instance.api.send_photo(chat_id: message.chat.id, photo: photo)
end

def post_details(bot_instance, message, text)
  bot_instance.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                       rating: text[1].values[0], title: text[1].values[1], overview: text[1].values[2], release: text[1].values[3]))
end

def post_trailer(bot_instance, message, text)
  bot_instance.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{text[2]}")
end

def return_result_based_on_command(command_name)
  movie = Movies.new
  code_to_use = movie.genre_code(command_name)
  result = movie.query_database_based_on_genre(code_to_use)
  result
end

def send_details_to_chat(bot_instance, message, results)
  movie = Movies.new
  results.each do |k|
    individual_movie = movie.result_data(k)
    post_photo(bot_instance, message, individual_movie[0])
    post_details(bot_instance, message, individual_movie)
    post_trailer(bot_instance, message, individual_movie)
  end
end
Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
      bot.api.send_message(chat_id: message.chat.id, text: 'Welcome, I am here to give you movie recommendations')
      bot.api.send_message(chat_id: message.chat.id, text:
        "Choose a genre\n/action\n/comedy\n/romance\n/drama\n/adventure\n/crime\n/documentary\n/war or\n/stop to quit")

    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name},hope to hear from you soon")

    when '/action'
      greet(bot, message)
      results = return_result_based_on_command('action')
      send_details_to_chat(bot, message, results)
    when '/comedy'
      greet(bot, message)
      results = return_result_based_on_command('comedy')
      send_details_to_chat(bot, message, results)

    when '/adventure'
      greet(bot, message)
      results = return_result_based_on_command('adventure')
      send_details_to_chat(bot, message, results)
    when '/animation'
      greet(bot, message)
      results = return_result_based_on_command('animation')
      send_details_to_chat(bot, message, results)
    when '/crime'
      greet(bot, message)
      results = return_result_based_on_command('crime')
      send_details_to_chat(bot, message, results)
    when '/documentary'
      greet(bot, message)
      results = return_result_based_on_command('documentary')
      send_details_to_chat(bot, message, results)
    when '/drama'
      greet(bot, message)
      results = return_result_based_on_command('drama')
      send_details_to_chat(bot, message, results)
    when '/family'
      greet(bot, message)
      results = return_result_based_on_command('family')
      send_details_to_chat(bot, message, results)
    when '/fantasy'
      greet(bot, message)
      results = return_result_based_on_command('fantasy')
      send_details_to_chat(bot, message, results)
    when '/history'
      greet(bot, message)
      results = return_result_based_on_command('history')
      send_details_to_chat(bot, message, results)
    when '/horror'
      greet(bot, message)
      results = return_result_based_on_command('horror')
      send_details_to_chat(bot, message, results)
    when '/music'
      greet(bot, message)
      results = return_result_based_on_command('music')
      send_details_to_chat(bot, message, results)
    when '/mystery'
      greet(bot, message)
      results = return_result_based_on_command('mystery')
      send_details_to_chat(bot, message, results)
    when '/romance'
      greet(bot, message)
      results = return_result_based_on_command('romance')
      send_details_to_chat(bot, message, results)
    when '/thriller'
      greet(bot, message)
      results = return_result_based_on_command('thriller')
      send_details_to_chat(bot, message, results)
    when '/war'
      greet(bot, message)
      results = return_result_based_on_command('war')
      send_details_to_chat(bot, message, results)
    when '/western'
      greet(bot, message)
      results = return_result_based_on_command('western')
      send_details_to_chat(bot, message, results)
    when '/sci-fi'
      greet(bot, message)
      results = return_result_based_on_command('sci-fi')
      send_details_to_chat(bot, message, results)
    when '/tv-movie'
      greet(bot, message)
      results = return_result_based_on_command('tv-movie')
      send_details_to_chat(bot, message, results)
    else
      bot.api.send_message(chat_id: message.chat.id, text: 'That is not a valid command')
      bot.api.send_message(chat_id: message.chat.id, text: "
        Try on one of the following commands for the genre you want\n/action\n/comedy\n/romance\n/drama\n/adventure\n/crime\n/documentary\n/war\n/western or\n/stop to end this session")
    end
  end
end
# rubocop:enable Layout/LineLength
