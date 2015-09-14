require 'rake'
require 'rake/testtask'
require "spec/rake/spectask"

desc "Default: run tests"
task :default => %w[test spec]

Rake::TestTask.new("test") do |t|
  t.pattern = "test/**/*_test.rb"
  t.verbose = true
end

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = %w[test/sample_spec.rb]
end

begin
  require "rcov/rcovtask"
  desc "run tests with rcov"
  Rcov::RcovTask.new do |t|
    t.pattern = "test/**/*_test.rb"
    t.rcov_opts << ["--no-html", "--exclude 'Library,#{Gem.path.join(',')}'"]
    t.verbose = true
  end
rescue LoadError
end

namespace :gemspec do
  desc "generates unit-record.gemspec"
  task :generate do
    File.open("unit-record.gemspec", "w") do |f|
      f.puts "# this file is generated by rake gemspec:generate for github"
      f.write gem_spec.to_ruby
    end
  end
end

task :readme do
  require "rubygems"; gem "BlueCloth"; require "BlueCloth"; require 'tmpdir'
  file = "#{Dir.tmpdir}/readme.html"
  File.open(file, "w") { |f| f.write BlueCloth.new(File.read("README.markdown")).to_html }
  sh "open #{file}"
end

desc "pre-commit task"
task :pc => %w[test:multi spec gemspec:generate]
