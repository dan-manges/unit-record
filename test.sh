#!/usr/bin/env sh
BUNDLE_GEMFILE=Gemfile.rails-3.2 bundle && BUNDLE_GEMFILE=Gemfile.rails-3.2 bundle exec rake
BUNDLE_GEMFILE=Gemfile.rails-3.1 bundle && BUNDLE_GEMFILE=Gemfile.rails-3.1 bundle exec rake
BUNDLE_GEMFILE=Gemfile.rails-3.0 bundle && BUNDLE_GEMFILE=Gemfile.rails-3.0 bundle exec rake
