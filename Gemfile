# frozen_string_literal: true

# To install Nokogiri for both Darwin (Mac) and Linux, run:
#   bundle lock --add-platform x86_64-linux && bundle lock --add-platform x86_64-darwin && bundle lock --add-platform arm64-darwin
# To make sure all platforms are added to vendor/cache, run:
#   bundle package --all-platforms

source 'https://rubygems.org'

# Gems required for all environments
gem 'jekyll'
gem 'jekyll-commonmark', git: 'https://github.com/jekyll/jekyll-commonmark'
gem 'jekyll-default-layout'
gem 'jekyll-feed', git: 'https://github.com/emmahsax/jekyll-feed'
gem 'jekyll-last-modified-at'
gem 'jekyll-mentions'
gem 'jekyll-paginate-v2'
gem 'jekyll-redirect-from'
gem 'jekyll-relative-links'
gem 'jekyll-seo-tag', git: 'https://github.com/emmahsax/jekyll-seo-tag'
gem 'jekyll-sitemap', git: 'https://github.com/emmahsax/jekyll-sitemap'
gem 'jekyll-tidy'
gem 'jekyll-time-to-read'
gem 'jekyll-titles-from-headings'
gem 'webrick'

# Gems for only test/development environment
group :test, :development do
  gem 'html-proofer'
  gem 'mdl'
  gem 'rubocop'
end
