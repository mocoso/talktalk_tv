require 'spec_helper'
require 'blinkbox_films'

describe 'A search' do
  context 'with zero results' do
    it { expect(BlinkboxFilms::Search.new.search('qwerty')).to be_empty }
  end

  context 'with some results' do
    subject { BlinkboxFilms::Search.new.search('dark knight') }

    it { expect(subject).to_not be_empty }
    it { expect(subject.first[:title]).to eq('The Dark Knight') }
    it { expect(subject.first[:url]).to eq('http://www.blinkbox.com/movies/the-dark-knight-(28710)') }
    it { expect(subject.first[:image_url]).to eq('http://cdn2.blinkboxmedia.com/i/contentasset31/000/028/710/1gkiab4e/v=316/w=234;h=132;rm=Crop;q=85/image.jpg') }
  end
end
