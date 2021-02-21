#!/bin/bash

bundle exec htmlproofer \
  --assume-extension \
  --allow-hash-href \
  --internal-domains /emmasax4.com/ \
  --url_ignore /linkedin/,/getitwriteonline/,/sopalodges/,/maasaimara/,/codepen.io/,/twitter.com/ \
  _site

# https://www.sopalodges.com/lake-naivasha-sopa-resort/the-resort
# https://getitwriteonline.com/articles/en-dashes-em-dashes/
# https://www.linkedin.com/in/emmahsax
# https://www.maasaimara.com/entries/fig-tree-camp
# https://codepen.io/Paulie-D/pen/zvkpJ/
# https://twitter.com - for some reason Twitter has been returning 400s consistently
