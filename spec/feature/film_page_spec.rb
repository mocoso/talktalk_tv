require 'spec_helper'
require 'blinkbox_films'

describe 'A film page', :vcr do
  subject { BlinkboxFilms::FilmPage.from_url('http://www.blinkbox.com/movies/the-dark-knight-(28710)').film }

  it { expect(subject.title).to eq('The Dark Knight') }
  it { expect(subject.url).to eq('http://www.blinkbox.com/movies/the-dark-knight-(28710)') }
  it { expect(subject.image_url).to match(%r{http://cdn\d+.blinkboxmedia.com/i/contentasset3/000/028/710/gl0lloqf/v=317/w=215;h=306;rm=Crop;q=85/image.jpg}) }
  it { expect(subject.release_year).to eq(2008) }
  it { expect(subject.certificate).to eq('12') }
  it { expect(subject.running_time_in_minutes).to eq(152) }
  it { expect(subject.rental_price).to eq('£2.49') }
  it { expect(subject.buy_price).to eq('£6.99') }
end

