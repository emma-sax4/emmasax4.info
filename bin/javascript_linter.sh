#!/bin/bash

npx --quiet standard assets/js/*.js | grep -v 'File ignored because of a matching ignore pattern.'

# Intentionally ignore any files that we intentionally ignore.
