#!/usr/bin/env ruby
require 'html-proofer'

HTMLProofer.check_directory('./_site', {
  assume_extension: true,
  allow_hash_href: true,
  internal_domains: [ /emmasax4.info/ ],
  url_ignore: [ /linkedin/, /digikey/ ],
  typhoeus: { timeout: 30 }
}).run
