require 'spec_helper'
require 'blinkbox_films'

describe 'A search' do
  context 'with zero results', :vcr do
    it { expect(BlinkboxFilms::Search.new.search('qwerty')).to be_empty }
  end

  context 'with some results', :vcr do
    subject { BlinkboxFilms::Search.new.search('dark knight') }

    it { expect(subject).to_not be_empty }
    it { expect(subject.first[:title]).to eq('The Dark Knight') }
    it { expect(subject.first[:url]).to eq('http://www.blinkbox.com/movies/the-dark-knight-(28710)') }
    it { expect(subject.first[:image_url]).to eq('http://cdn2.blinkboxmedia.com/i/contentasset31/000/028/710/1gkiab4e/v=316/w=234;h=132;rm=Crop;q=85/image.jpg') }
    it { expect(subject.first[:certificate]).to eq('12') }
    it { expect(subject.first[:running_time_in_minutes]).to eq(152) }
  end

  context 'with unrecognised page format returned' do
    before do
      VCR.turn_off!

      stub_request(:get, "http://www.blinkbox.com/search?Search=dark%20knight").
        to_return(:body => '<html><body><h1>Not what you expected</h1></body></html>')
    end

    after do
      VCR.turn_on!
    end

    it do
      expect {
        BlinkboxFilms::Search.new.search('dark knight') 
      }.to raise_error('BlinkboxFilms::SearchResultsPageNotRecognised')
    end
  end
end
