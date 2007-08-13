namespace :db do
  namespace :columns do
    desc "Create a db/columns.rb file that can be used to unit test"
    task :dump => :environment do
      File.open(ENV['FILE'] || "db/columns.rb", "w") do |file|
        ActiveRecord::ColumnDumper.dump(ActiveRecord::Base.connection, file)
      end
    end
  end
end
