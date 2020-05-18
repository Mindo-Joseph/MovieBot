require 'rest-client'
require_relative '../keys.rb'
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
  def result_data(item)
    output = []
    image = generate_poster_link(item)
    text_array = fetch_movie_details(item)
    trailer = generate_youtube_link(item)
    output << image
    output << text_array
    output << trailer
    output
  end
  
  
  def query_database_based_on_genre(genre_code)
    response = RestClient::Request.new(
      method: :get,
      url: "https://api.themoviedb.org/3/discover/movie?api_key=#{API_KEY}&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=#{genre_code}"
    ).execute
    result = JSON.parse(response.to_s)
    result['results'][0, 3]
  end
  private
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
    if result['results'].length == 0
      return "There is no available information for this movie right now"
    elsif result['results'][0].has_key?('key') == false
      return "Unfortunately I cannot find the trailer for this, sorry"
    else
      key = result['results'][0].fetch('key')

      return "https://www.youtube.com/watch?v=#{key}"
    end
    
  end

  def generate_poster_link(item)

    if item.has_key?('poster_path') == false
      return "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.TivqJXhvJUEE3pcexwYmwgHaFj%26pid%3DApi&f=1"
    elsif item.fetch('poster_path') == nil
      return "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.TivqJXhvJUEE3pcexwYmwgHaFj%26pid%3DApi&f=1"
    else 
      img_url = item.fetch('poster_path')
      return "https://image.tmdb.org/t/p/w500/#{img_url}"
    end
  end
end

# movies = Movies.new
# detail = {"popularity"=>213.559, "vote_count"=>2272, "video"=>false, "poster_path"=>"/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg", "id"=>338762, "adult"=>false, "backdrop_path"=>"/ocUrMYbdjknu2TwzMHKT9PBBQRw.jpg", "original_language"=>"en", "original_title"=>"Bloodshot", "genre_ids"=>[28, 18, 878], "title"=>"Bloodshot", "vote_average"=>7.1, "overview"=>"After he and his wife are murdered, marine Ray Garrison is resurrected by a team of scientists. Enhanced with nanotechnology, he becomes a superhuman, biotech killing machine—'Bloodshot'. As Ray first trains with fellow super-soldiers, he cannot recall anything from his former life. But when his memories flood back and he remembers the man that killed both him and his wife, he breaks out of the facility to get revenge, only to discover that there's more to the conspiracy than he thought.", "release_date"=>"2020-03-05"}
# output = movies.result_data(detail)
# print output
# puts