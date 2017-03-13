#!/bin/bash

#clean tmp directory
rm -rf /app/tmp/*

#start redis server
/etc/init.d/redis-server start

#switch  config file to use sqlite3 db
/usr/local/bin/switch2sqlite.rb

#change to the app diretory
cd /app

#start solr and fedora
rake jetty:start

#create DB if it does not exists
if [ ! -e /app/db/hydranorth.sqlite3 ]; then
  rake db:migrate
  rake db:seed
fi

bundle check || bundle install

#start resque pool
bundle exec resque-pool --daemon --environment development && sleep 7

rails server -b 0.0.0.0
