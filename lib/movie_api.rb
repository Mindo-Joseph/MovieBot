require 'rest-client'
require '/home/joe/Desktop/Projects/TeleBot/token.rb'
require 'json'
class Movies
  def genre_code(key)
    genres_hash = Hash.new('genre')
    genres_hash = { 'action' => 28, 'drama' => 18, 'adventure' => 12, 
                    'animation' => 16, 'comedy' => 35, 'crime' => 80, 'documentary' => 99, 'family' => 10_751, 'fantasy' => 14, 'history' => 36,
                    'horror' => 27, 'music' => 10_402, 'mystery' => 9648,
                    'romance' => 10_749, 'sci-fi' => 878, 'tv-movie' => 10_770, 
                    'thriller' => 53, 'war' => 10_752, 'western' => 37 }
    genres_hash[key]
  end
end
