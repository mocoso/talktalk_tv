require 'uri'
require 'nokogiri'
require 'httpclient'

module BlinkboxFilms
  class FilmPage
    def initialize(body:, url: nil)
      @body = body
      @url = url
    end

    attr_reader :body, :url

    def self.from_url(url)
      response = HTTPClient.new.get(url)
      FilmPage.new(body: Nokogiri::HTML(response.body), url: url)
    end

    def film
      Film.new(
        title: title,
        url: url,
        image_url: image_url,
        release_year: release_year,
        certificate: certificate,
        running_time_in_minutes: running_time_in_minutes,
        rental_price: rental_price,
        buy_price: buy_price
      )
    end

    def title
      body.css('h1').first.content.strip
    end

    def image_url
      body.css('.c-packShot noscript img').first.attributes['src'].value
    end

    def release_year
      match = body.css('.g-assetInfo li').map { |n| %r{(\d{4})}.match(n.content) }.compact.first
      match && match[1].to_i
    end

    def certificate
      match = body.css('.g-assetInfo li').map { |n| %r{CERT (.*)}.match(n.content) }.compact.first
      match && match[1]
    end

    def running_time_in_minutes
      match = body.css('.g-assetInfo li').map { |n| %r{(\d+) HRS (\d+) MINS}.match(n.content) }.compact.first
      match && (match[1].to_i * 60 + match[2].to_i)
    end

    def rental_price
      select_price(body, '.c-retailButton--rental .c-retailButton__price  > text()')
    end

    def buy_price
      select_price(body, '.c-retailButton--purchase .c-retailButton__price  > text()')
    end

    private
    def select_price(body, selector)
      price_tag = body.css(selector).first
      price_tag && price_tag.text.strip
    end
  end
end
