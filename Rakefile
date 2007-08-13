require 'rake'
require 'rake/testtask'

desc "Default: run tests"
task :default => :test

desc "Run all tests"
task :test => %w[test:caching test:disconnecting]

desc "Run the tests for caching columns"
Rake::TestTask.new("test:caching") do |t|
  t.libs << 'lib'
  t.pattern = 'test/caching/**/*_test.rb'
  t.verbose = true
end
