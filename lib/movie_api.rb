require 'rest-client'
require './token.rb'
require 'json'
require 'telegram/bot'
class Movies
  @keys_to_use = []

  def genre_code(key)
    genres_hash = { 'action' => 28, 'drama' => 18, 'adventure' => 12,
                    'animation' => 16, 'comedy' => 35, 'crime' => 80, 'documentary' => 99, 'family' => 10_751, 'fantasy' => 14, 'history' => 36,
                    'horror' => 27, 'music' => 10_402, 'mystery' => 9648,
                    'romance' => 10_749, 'sci-fi' => 878, 'tv-movie' => 10_770,
                    'thriller' => 53, 'war' => 10_752, 'western' => 37 }
    genres_hash[key]
  end

  def query_database_based_on_genre(genre_code)
    response = RestClient::Request.new(
      method: :get,
      url: "https://api.themoviedb.org/3/discover/movie?api_key=#{API_KEY}&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=#{genre_code}"
    ).execute
    result = JSON.parse(response.to_s)
    result['results'][0, 3]
  end

  def fetch_movie_details(item)
    categories = %w[popularity overview release_date title]
    item.select { |k, _v| categories.include?(k) }
  end

  def generate_youtube_link(item)
    id = item.fetch('id')
    response = RestClient::Request.new(
      method: :get,
      url: "http://api.themoviedb.org/3/movie/#{id}/videos?api_key=#{API_KEY}"
    ).execute
    result = JSON.parse(response.to_s)
    key = result['results'][0].fetch('key')
    "https://www.youtube.com/watch?v=#{key}"
  end

  def generate_poster_link(item)
    img_url = item.fetch('poster_path')
    "https://image.tmdb.org/t/p/w500/#{img_url}"
  end
end

def result_data(item)
  output = []
  movie = Movies.new
  image = movie.generate_poster_link(item)
  text_array = movie.fetch_movie_details(item)
  trailer = movie.generate_youtube_link(item)
  output << image
  output << text_array
  output << trailer
  output
end
