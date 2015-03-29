#!/usr/bin/env bash
bundle install
rake db:create
rake db:migrate
redis-server & bundle exec sidekiq & rails s