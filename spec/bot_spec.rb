require './lib/movie_api.rb'
RSpec.describe 'MovieTellBot' do
  describe 'Bot' do
    it 'starts by greeting user when /start command is passed' do
    end
  end
  describe 'Movies' do
    let(:movies) { Movies.new }
    let(:data) {movies.query_database_based_on_genre(28)}
    it 'returns correct genre code' do
      expect(movies.genre_code('romance')).to eq(10_749)
    end
  
    it 'gets movie details of relevant keys' do
      item = data[0]
      details_array = movies.fetch_movie_details(item)
      expect(details_array.length).to eq(4)
    end
    it 'returns an array of result data' do
      
    end
  end
end
