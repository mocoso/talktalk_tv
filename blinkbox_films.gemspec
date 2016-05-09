Gem::Specification.new do |s|
  s.name        = 'blinkbox_films'
  s.version     = '0.0.6'
  s.date        = '2015-12-28'
  s.summary     = "A simple search API for blinkbox.com"
  s.description = "Built with some wonky page scraping"
  s.authors     = ["Joel Chippindale"]
  s.email       = 'joel@joelchippindale.com'
  s.homepage    = 'https://github.com/mocoso/blinkbox_films'
  s.license = 'MIT'
  s.files       = Dir['lib/**/*.rb'] + Dir['spec/**/*.rb'] +
                    ['Rakefile', 'LICENSE.txt']

  s.add_runtime_dependency 'nokogiri', '~> 1.6'
  s.add_runtime_dependency 'httpclient', '~> 2.7'
  s.add_development_dependency 'rake', '~> 10'
  s.add_development_dependency 'rspec', '~> 3'
  s.add_development_dependency 'webmock', '~> 1.22'
  s.add_development_dependency 'vcr', '~> 3.0'
end
