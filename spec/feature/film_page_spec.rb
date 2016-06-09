require 'spec_helper'
require 'talktalk_tv'

describe 'A film page', :vcr do
  context 'A film' do
    subject { TalkTalkTV::FilmPage.from_url('https://www.talktalktvstore.co.uk/movies/the-dark-knight-(28710)').film }

    it { expect(subject.title).to eq('The Dark Knight') }
    it { expect(subject.url).to eq('https://www.talktalktvstore.co.uk/movies/the-dark-knight-(28710)') }
    it { expect(subject.image_url).to eq('https://fa-i-p1.ttcdn.uk/i/contentasset3/000/028/710/gl0lloqf/v=319/w=215;h=306;rm=Crop;q=85/image.jpg') }
    it { expect(subject.release_year).to eq(2008) }
    it { expect(subject.certificate).to eq('12') }
    it { expect(subject.running_time_in_minutes).to eq(152) }
    it { expect(subject.rental_price).to eq('£2.49') }
    it { expect(subject.buy_price).to eq('£6.99') }
  end

  context 'A single TV series' do
    subject { TalkTalkTV::FilmPage.from_url('https://www.talktalktvstore.co.uk/tv/12-monkeys-(2313)/s01-(3555)').film }

    it { expect(subject.title).to eq('12 Monkeys') }
    it { expect(subject.url).to eq('https://www.talktalktvstore.co.uk/tv/12-monkeys-(2313)/s01-(3555)') }
    it { expect(subject.image_url).to eq('https://fa-i-p1.ttcdn.uk/i/tvseries/000/002/313/yzr3t1rw/v=319/w=215;h=306;rm=Crop;q=85/image.jpg') }
    it { expect(subject.release_year).to eq(2015) }
    it { expect(subject.certificate).to eq('15') }
    it { expect(subject.running_time_in_minutes).to be_nil }
    it { expect(subject.rental_price).to be_nil }
    it { expect(subject.buy_price).to eq('£9.99') }
  end
end

