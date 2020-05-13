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

  def query_database_based_on_genre(genre_code)
    response = RestClient::Request.new(
      :method => :get,
      :url => "https://api.themoviedb.org/3/discover/movie?api_key=#{$api_key}&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=#{genre_code}"
    ).execute
    result = JSON.parse(response.to_s)
    result["results"][0,3]
  end
  def create_keys_array(hash)
    hash = hash[0]
    hash.each_with_object([]) do |(k,v),keys|
      keys << k
      keys.select! { |tag| tag == "popularity" || tag == "poster_path" || tag == "title" || tag == "overview"  || tag == "release_date"}
    end
  end

end

c = Movies.new
v = c.query_database_based_on_genre(28)
f = c.create_keys_array(v)
print f
puts
# letters = Hash["one" => 1, "two" => 2]
# result = letters.fetch("one")
# print result
