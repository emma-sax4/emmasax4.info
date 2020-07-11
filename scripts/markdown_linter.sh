#!/bin/bash

bundle exec mdl -i \
  -r ~MD013,~MD002,~MD033,~MD026,~MD029,~MD046,~MD001,~MD024, ~MD034 \
  README.md \
  .github \
  pages \
  _legos \
  _blog_posts
