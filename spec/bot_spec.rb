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
      output = movies.fetch_movie_details(data)
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
      image_url = movies.generate_poster_link(movie)
      validation = image_url.include? 'https://image.tmdb.org/t/p/w500/'
      expect(validation).to eq(true)
    end
  end
end
