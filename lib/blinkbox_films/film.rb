module BlinkboxFilms
  class Film
    def initialize(title:, url:, image_url:, certificate:, running_time_in_minutes:)
      @title = title
      @url = url
      @image_url = image_url
      @certificate = certificate
      @running_time_in_minutes = running_time_in_minutes
    end

    attr_reader :title, :url, :image_url, :certificate, :running_time_in_minutes
  end
end
