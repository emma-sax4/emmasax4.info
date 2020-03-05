#!/bin/bash

GEM=$(gem list html-proofer)

if [ -z $GEM ]; then
  gem install html-proofer
fi
