require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rake/contrib/sshpublisher'

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

desc "Run the tests for disconnecting"
Rake::TestTask.new("test:disconnecting") do |t|
  t.libs << 'lib'
  t.pattern = 'test/disconnecting/**/*_test.rb'
  t.verbose = true
end

desc "Generate documentation"
Rake::RDocTask.new(:doc) do |rdoc|
  rdoc.rdoc_dir = "doc"
  rdoc.title    = "UnitRecord"
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README')
end

desc "Upload RDoc to RubyForge"
task :publish_rdoc => [:rdoc] do
  Rake::SshDirPublisher.new("dcmanges@rubyforge.org", "/var/www/gforge-projects/unit-test-ar", "doc").upload
end

Gem::manage_gems

specification = Gem::Specification.new do |s|
	s.name   = "unitrecord"
  s.summary = "UnitRecord enables unit testing without hitting the database."
	s.version = "0.1"
	s.author = "Dan Manges"
	s.description = "UnitRecord enables unit testing without hitting the database."
	s.email = "daniel.manges@gmail.com"
  s.homepage = "http://unit-test-ar.rubyforge.org"
  s.rubyforge_project = "unit-test-ar"

  s.has_rdoc = true
  s.extra_rdoc_files = ['README']
  s.rdoc_options << '--title' << "UnitRecord" << '--main' << 'README' << '--line-numbers'

  s.autorequire = "unit_record"
  s.files = FileList['{lib,test}/**/*.rb', '^[A-Z]+$', 'Rakefile', 'init.rb'].to_a
end

Rake::GemPackageTask.new(specification) do |package|
  package.need_zip = false
  package.need_tar = false
end
