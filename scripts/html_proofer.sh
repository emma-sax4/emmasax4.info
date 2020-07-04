#!/bin/bash

bundle exec htmlproofer \
  --assume-extension \
  --allow-hash-href \
  --internal-domains /emmasax4.info/ \
  ./_site/
