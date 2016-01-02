blinkbox\_films is a Ruby gem which provides a page scraped API for
searching the films and tv shows available for streaming from blinkbox.com

# Installation

    $ gem install blinkbox_films

Or with Bundler in your Gemfile.

    gem 'blinkbox_films'

# Usage

    require 'blinkbox_films'

    blinkbox_search = BlinkboxFilms::Search.new
    
    results = blinkbox_search.search('toy story')
    
Where the results are an array containing a hash for each result. Each
result has `title`, `url` and `image_url` keys.
