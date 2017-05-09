#!/bin/bash

#clean tmp directory
rm -rf /app/tmp/*

#start redis server
/etc/init.d/redis_6379 start

#switch config file to use mysql db
/usr/local/bin/switch2mysql.rb

#start mysql server
/etc/init.d/mysqld start

#create hydranorthdev database
echo "Creating database hydranorthdev and hydranorthtest"
mysql -u root -e "Create database hydranorthdev;"
mysql -u root -e "Create database hydranorthtest;"

#change to the app directory
cd /app

#check and install gems
bundle check || bundle install

#start solr and fedora
rake jetty:start

#create DB and seed it
rake db:migrate
rake db:seed


#start resque pool
bundle exec resque-pool --daemon --environment development && sleep 7

rails server -b 0.0.0.0
