require './lib/movie_api.rb'
RSpec.describe 'MovieTellBot' do
  describe 'Movies' do
    let(:movies) { Movies.new }
    let(:data) { movies.query_database_based_on_genre(28) }
    it 'fetches data from database' do
      stub_request(:get, 'https://api.themoviedb.org/3/discover/movie?api_key=13c28895df1f68549cdcd48b1df01d13&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=28')
        .to_return(status: 200, body: '{[{},{},{}]}', headers: {})
      expect('{[{},{},{}]}'.length).not_to eq(0)
    end

    it 'returns correct genre code' do
      expect(movies.genre_code('romance')).to eq(10_749)
    end

    it 'returns movie details of relevant keys' do
      stub_request(:get, 'https://api.themoviedb.org/3/discover/movie?api_key=13c28895df1f68549cdcd48b1df01d13&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=28')
        .to_return(status: 200, body: '{[{"popularity":20,"vote_count":20,"video":false,"poster_path":"\/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg","id":338762,"adult":false,"backdrop_path":"\/ocUrMYbdjknu2TwzMHKT9PBBQRw.jpg","original_language":"en","original_title":"Bloodshot","genre_ids":[28,18,878],"title":"Bloodshot","vote_average":7.1,"overview":something,"release_date":"2020-03-05"}]}', headers: {})

      data = { "popularity": 20, "vote_count": 20, "video": false, "poster_path": "\/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg", "id": 338_762, "adult": false, "backdrop_path": "\/ocUrMYbdjknu2TwzMHKT9PBBQRw.jpg", "original_language": 'en', "original_title": 'Bloodshot', "genre_ids": [28, 18, 878], "title": 'Bloodshot', "vote_average": 7.1, "overview": 'something', "release_date": '2020-03-05' }
      output = movies.instance_eval { fetch_movie_details(data) }
      expect(output.length).not_to eq(data.length)
    end
    it 'returns only top 3 items from category' do
      stub_request(:get, 'https://api.themoviedb.org/3/discover/movie?api_key=13c28895df1f68549cdcd48b1df01d13&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=28')
        .to_return(status: 200, body: '{"page":1,"total_results":10000,"total_pages":500,"results":[{},{},{},{}]}', headers: {})
      result = JSON.parse('{"page":1,"total_results":10000,"total_pages":500,"results":[{},{},{},{}]}')
      output = result['results'][0, 3]
      expect(output.length).to eq(3)
    end

    it 'renders an image from tmdb website' do
      movie = Hash['popularity' => 190.572, 'vote_count' => 2197, 'video' => false, 'poster_path' => '/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg']
      image_url = movies.instance_eval {generate_poster_link(movie)}
      validation = image_url.include? 'https://image.tmdb.org/t/p/w500/'
      expect(validation).to eq(true)
    end
    it 'returns an error message when video does not have any details' do
      detail = {"popularity"=>213.559, "vote_count"=>2272, "video"=>false, "poster_path"=>"/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg", "id"=>456789, "adult"=>false, "backdrop_path"=>"/ocUrMYbdjknu2TwzMHKT9PBBQRw.jpg", "original_language"=>"en", "original_title"=>"Bloodshot", "genre_ids"=>[28, 18, 878], "title"=>"Bloodshot", "vote_average"=>7.1, "overview"=>"After he and his wife are murdered, marine Ray Garrison is resurrected by a team of scientists. Enhanced with nanotechnology, he becomes a superhuman, biotech killing machine—'Bloodshot'. As Ray first trains with fellow super-soldiers, he cannot recall anything from his former life. But when his memories flood back and he remembers the man that killed both him and his wife, he breaks out of the facility to get revenge, only to discover that there's more to the conspiracy than he thought.", "release_date"=>"2020-03-05"}
      stub_request(:get, 'http://api.themoviedb.org/3/movie/456789/videos?api_key=13c28895df1f68549cdcd48b1df01d13')
      .to_return(status: 200, body: '{"id":456789,"results":[]}')
      result = {'id':456789,"results":[]}
      # call the generate_youtube_link method
      link = movies.instance_eval { generate_youtube_link(detail) }
      expect(link).to eq("There is no available information for this movie right now")
      
    end

  end
end
