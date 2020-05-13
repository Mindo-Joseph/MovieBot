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
    it 'generates an array of item keys' do
      
      hash = Hash["a" => 1, "b" => 2]
      item = movies.create_keys_array(hash)
      expect(item).to eq(["a","b"])
    end
  end
end
