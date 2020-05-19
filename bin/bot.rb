#!/usr/bin/env ruby
require 'telegram/bot'
require_relative '../keys.rb'
require_relative '../lib/movie_api.rb'
# rubocop:disable Layout/LineLength
movie = Movies.new
Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    def respond(item); end
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
      bot.api.send_message(chat_id: message.chat.id, text: 'Welcome, I am here to give you movie recommendations')
      bot.api.send_message(chat_id: message.chat.id, text:
        "Choose a genre\n/action\n/comedy\n/romance\n/drama\n/adventure\n/crime\n/documentary\n/war or\n/stop to quit")

    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name},hope to hear from you soon")

    when '/action'
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('action')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\n
        Title: %<title>s\nOverview: %<overview>s\nRelease Date%<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))

        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end

    when '/comedy'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get comedy movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('comedy')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/adventure'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get adventure movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('adventure')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/animation'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get animation movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('animation')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/crime'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get crime movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('crime')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/documentary'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get documentary movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('documentary')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/drama'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get drama movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('drama')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/family'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get family movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('family')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/fantasy'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get fantasy movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('fantasy')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/history'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get history movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('history')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/horror'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get horror movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('horror')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/music'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get music movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('music')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/mystery'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get mystery movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('mystery')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/romance'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get romance movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('romance')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/thriller'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get thriller movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('thriller')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/war'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get war movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('war')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/western'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get western movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('western')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/sci-fi'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get sci-fi movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('sci-fi')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    when '/tv-movie'
      bot.api.send_message(chat_id: message.chat.id, text: 'Great choice! Lemme get tv-movie movies for you')
      bot.api.send_message(chat_id: message.chat.id, text: 'These are the top 3 highest movies today in your category')
      code = movie.genre_code('tv-movie')
      result = movie.query_database_based_on_genre(code)
      result.each do |k|
        c = movie.result_data(k)
        bot.api.send_photo(chat_id: message.chat.id, photo: c[0])
        bot.api.send_message(chat_id: message.chat.id, text: format("Rating: %<rating>s\nTitle: %<title>s\nOverview: %<overview>s\nRelease Date %<release>s",
                                                                    rating: c[1].values[0], title: c[1].values[1], overview: c[1].values[2], release: c[1].values[3]))
        bot.api.send_message(chat_id: message.chat.id, text: "Here is the trailer #{c[2]}")
      end
    else
      bot.api.send_message(chat_id: message.chat.id, text: 'That is not a valid command')
      bot.api.send_message(chat_id: message.chat.id, text: "
        Try on one of the following commands for the genre you want\n/action\n/comedy\n/romance\n/drama\n/adventure\n/crime\n/documentary\n/war\n/western or\n/stop to end this session")
    end
  end
end
# rubocop:enable Layout/LineLength
