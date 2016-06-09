require 'uri'
require 'nokogiri'
require 'httpclient'

module TalkTalkTV
  class Search
    def search(query)
      r = response(query)
      films = film_fragments(r.body).map { |f|
        Film.new(
          title: film_title(f),
          url: film_url(f),
          image_url: film_image_url(f),
          certificate: film_certificate(f),
          running_time_in_minutes: film_running_time_in_minutes(f)
        )
      }

      if films.empty? & !no_results_page?(r.body)
        raise TalkTalkTV::SearchResultsPageNotRecognised
      else
        films
      end
    end

    private
    def no_results_page?(page)
      page.include?('no results found for')
    end

    def response(query)
      HTTPClient.new.get('https://www.talktalktvstore.co.uk/search', { 'Search' => query })
    end

    def film_fragments(page)
      Nokogiri::HTML(page).css('.p-searchResults li.b-assetCollection__item')
    end

    def film_title(fragment)
      fragment.css('h3').first.content.strip
    end

    def film_url(fragment)
      u = URI.parse(extract_film_path_or_url(fragment))
      u.host ||= 'www.talktalktvstore.co.uk'
      u.scheme ||= 'https'
      u.to_s
    end

    def extract_film_path_or_url(fragment)
      fragment.css('h3 a').first.attributes['href'].value
    end

    def film_image_url(fragment)
      fragment.css('noscript img').first.attributes['src'].value
    end

    def film_certificate(fragment)
      match = fragment.css('.c-assetCollectionItem__metaDataItem').map { |n| %r{CERT (\S+)}.match(n.content) }.compact.first
      match && match[1]
    end

    def film_running_time_in_minutes(fragment)
      match = fragment.css('.c-assetCollectionItem__metaDataItem').map { |n| %r{(\d+) HRS? (\d+) MINS?}.match(n.content) }.compact.first
      match && (match[1].to_i * 60 + match[2].to_i)
    end
  end
end
