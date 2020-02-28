#!/bin/bash
echo "export BUNDLER_VERSION=$(cat Gemfile.lock | tail -1 | tr -d ' ')" >> $BASH_ENV
source $BASH_ENV
gem install bundler
