require './lib/movie_api.rb'
RSpec.describe 'MovieTellBot' do
  describe 'Bot' do
    it 'starts by greeting user when /start command is passed' do
    end
  end
  describe 'Movies' do
    let(:movies) { Movies.new }
    it 'returns correct genre code' do
      expect(movies.genre_code('romance')).to eq(10_749)
    end
    it 'gets movie details of relevant keys' do
      data = movies.query_database_based_on_genre(28)
      item = data[0]
      details_array = movies.fetch_movie_details(item)
      expect(details_array.length).to eq(4)
    end
  end
end
