require 'spec_helper'

describe TalkTalkTV::FilmPage do
  describe '#buy_price' do
    subject { TalkTalkTV::FilmPage.new(body: body) }

    context 'standard price' do
      let(:body) {
        Nokogiri::HTML('<button type="submit" class="c-retailButton c-retailButton--purchase">
          BUY
          <span class="c-retailButton__price">
            £6.99
          </span>
        </button>')
      }

      it { expect(subject.buy_price).to eq('£6.99') }
    end

    context 'discount price' do
      let(:body) {
        Nokogiri::HTML('<button type="submit" class="c-retailButton c-retailButton--purchase">
          BUY
          <span class="c-retailButton__price">
            £3.99
            <span class="c-retailButton__saving c-retailButton__saving--purchase">
              £6.99
            </span>
          </span>
        </button>')
      }

      it { expect(subject.buy_price).to eq('£3.99') }
    end
  end
end

