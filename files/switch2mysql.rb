#!/usr/bin/env ruby

require 'yaml' # Built in, no gem required
gFile = YAML::load_file('/app/config/database.yml') #Load
gFile['development']['adapter'] = 'mysql2'
gFile['development']['database'] = 'hydranorthdev'
File.open('/app/config/database.yml', 'w') {|f| f.write gFile.to_yaml } #Store
