require 'uri'
require 'nokogiri'

class BlinkboxSearch
  def search(query)
    r = response(query)
    if r.is_a?(Net::HTTPSuccess)
      rental_fragments(r.body).map { |f|
        {
          :title => rental_title(f),
          :url => rental_url(f),
          :image_url => rental_image_url(f)
        }
      }
    else
      []
    end
  end

  private
  def search_url(query)
    "http://www.blinkbox.com/search?#{URI.encode_www_form([['Search', query]])}"
  end

  def response(query)
    Net::HTTP.get_response(URI(search_url(query)))
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
