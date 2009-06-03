require 'spec'

here = File.dirname(__FILE__)
$LOAD_PATH.unshift here
$LOAD_PATH.unshift "#{here}/../lib"

require 'activerecord'

require 'feedra'

ActiveRecord::Migration.verbose = false
RAILS_ROOT = here
RAILS_DEFAULT_LOGGER = Logger.new("#{RAILS_ROOT}/test.log") 

Spec::Runner.configure do |config|

  config.before(:all) do
    FileUtils.mkdir_p "#{here}/migrate"
    FileUtils.cp "#{here}/../generators/feedra/templates/migration.rb", "#{here}/migrate/001_create_feed_and_events.rb"

    ActiveRecord::Base.logger = Logger.new("#{here}/activerecord_base.log")

    ActiveRecord::Base.establish_connection :adapter => 'sqlite3',
                                            :database => ':memory:'
    
    ActiveRecord::Migrator.migrate "#{here}/migrate"
  end
  
end
