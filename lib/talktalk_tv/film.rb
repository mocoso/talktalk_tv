module TalkTalkTV
  class Film
    def initialize(
      title:,
      url: nil,
      image_url: nil,
      certificate: nil,
      release_year: nil,
      running_time_in_minutes: nil,
      buy_price: nil,
      rental_price: nil
    )
      @title = title
      @url = url
      @image_url = image_url
      @certificate = certificate
      @release_year = release_year
      @running_time_in_minutes = running_time_in_minutes
      @buy_price = buy_price
      @rental_price = rental_price
    end

    attr_reader :title, :url, :image_url, :certificate, :release_year,
      :running_time_in_minutes, :buy_price, :rental_price
  end
end
