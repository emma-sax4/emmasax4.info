#!/bin/bash

# Intentionally ignore any files that we are trying to intentionally ignore.
npx --quiet standard --ignore-pattern='assets/js/*.min.js' 'assets/js/*.js'
