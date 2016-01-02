require 'uri'
require 'nokogiri'
require 'httpclient'

module BlinkboxFilms
  class Search
    def search(query)
      r = response(query)
      rentals = rental_fragments(r.body).map { |f|
        {
          :title => rental_title(f),
          :url => rental_url(f),
          :image_url => rental_image_url(f)
        }
      }

      if rentals.empty? & !no_results_page?(r.body)
        raise BlinkboxFilms::SearchResultsPageNotRecognised
      else
        rentals
      end
    end

    private
    def no_results_page?(page)
      page.include?('no results found for')
    end

    def response(query)
      HTTPClient.new.get('http://www.blinkbox.com/search', { 'Search' => query })
    end

    def rental_fragments(page)
      Nokogiri::HTML(page).css('.p-searchResults li.b-assetCollection__item')
    end

    def rental_title(fragment)
      fragment.css('h3').first.content.strip
    end

    def rental_url(fragment)
      u = URI.parse(extract_rental_path_or_url(fragment))
      u.host ||= 'www.blinkbox.com'
      u.scheme ||= 'http'
      u.to_s
    end

    def extract_rental_path_or_url(fragment)
      fragment.css('h3 a').first.attributes['href'].value
    end

    def rental_image_url(fragment)
      fragment.css('noscript img').first.attributes['src'].value
    end
  end
end
