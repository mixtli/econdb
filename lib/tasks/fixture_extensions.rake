namespace :db do
namespace :fixtures do

desc "Create YAML fixtures from data in the current environment's database. Dump specific tables using TABLES=x[,y,z]."
task :dump => :environment do
      ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)
      fixtures_dir = ENV['FIXTURES_DIR'] || File.join(RAILS_ROOT, 'db', 'fixtures')
      limit = 50
      tables = ENV['TABLES'] ? ENV['TABLES'].split(/,/) : ActiveRecord::Base.connection.tables - ["schema_info", "sessions" ]
      tables.each do |table_name| 
        record_number = 0
        offset = 0
        File.open(File.join(fixtures_dir, "#{table_name}.yml"), 'w' ) do |file|
          while !(data = ActiveRecord::Base.connection.select_all("SELECT * FROM %s LIMIT %d OFFSET %d" % [table_name, limit, offset])).empty?
            data.each do |record|
              file.write({"#{table_name}_#{record_number += 1}" => record}.to_yaml.gsub(/^---.*\n/, ''))
            end
            offset += limit
          end
        end
      end
end

desc "Load seed fixtures (from db/fixtures) into the current environment's database." 
task :seed => :environment do
  require 'active_record/fixtures'
  Dir.glob(RAILS_ROOT + '/db/fixtures/*.yml').each do |file|
    Fixtures.create_fixtures('db/fixtures', File.basename(file, '.*'))
  end
end

end
end
           