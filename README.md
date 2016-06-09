talktalk\_tv is a Ruby gem which provides a page scraped API for
searching the films and tv shows available for streaming from
https://www.talktalktvstore.co.uk

# Installation

    $ gem install talktalk_tv

Or with Bundler in your Gemfile.

    gem 'talktalk_tv'

# Usage

    require 'talktalk_tv'

    talktalk_tv_search = TalkTalkTV::Search.new
    
    results = talktalk_tv_search.search('toy story')
    
Where the results are an array containing a hash for each result. Each
result has `title`, `url` and `image_url` keys.
