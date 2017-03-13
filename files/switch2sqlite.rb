#!/usr/bin/env ruby

require 'yaml' # Built in, no gem required
gFile = YAML::load_file('/app/config/database.yml') #Load
gFile['development']['adapter'] = 'sqlite3'
gFile['development']['database'] = 'db/hydranorth.sqlite3'
File.open('/app/config/database.yml', 'w') {|f| f.write gFile.to_yaml } #Store
