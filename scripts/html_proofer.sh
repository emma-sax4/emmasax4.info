#!/bin/bash

bundle exec htmlproofer \
  --assume-extension \
  --allow-hash-href \
  --internal-domains /emmasax4.info/ \
  --url_ignore /linkedin, getitwriteonline, sopalodges/ \
  ./_site/

# https://www.sopalodges.com/lake-naivasha-sopa-resort/the-resort
# https://getitwriteonline.com/articles/en-dashes-em-dashes/
# https://www.linkedin.com/in/emmasax4
