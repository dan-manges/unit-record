require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rake/contrib/sshpublisher'

desc "Default: run tests"
task :default => :test

desc "Run all tests"
task :test => %w[test:unit test:functional]

Rake::TestTask.new("test:unit") do |t|
  t.libs << 'lib'
  t.pattern = 'test/unit/**/*_test.rb'
  t.verbose = true
end

Rake::TestTask.new("test:functional") do |t|
  t.libs << 'lib'
  t.pattern = 'test/functional/**/*_test.rb'
  t.verbose = true
end

desc "Generate documentation"
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = "doc"
  rdoc.title    = "UnitRecord"
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README', 'CHANGELOG')
end

desc "Upload RDoc to RubyForge"
task :publish_rdoc => [:rdoc] do
  Rake::SshDirPublisher.new("dcmanges@rubyforge.org", "/var/www/gforge-projects/unit-test-ar", "doc").upload
end

Gem::manage_gems

specification = Gem::Specification.new do |s|
	s.name   = "unit_record"
  s.summary = "UnitRecord enables unit testing without hitting the database."
	s.version = "0.3.0"
	s.author = "Dan Manges"
	s.description = "UnitRecord enables unit testing without hitting the database."
	s.email = "daniel.manges@gmail.com"
  s.homepage = "http://unit-test-ar.rubyforge.org"
  s.rubyforge_project = "unit-test-ar"

  s.has_rdoc = true
  s.extra_rdoc_files = ['README', 'CHANGELOG']
  s.rdoc_options << '--title' << "UnitRecord" << '--main' << 'README' << '--line-numbers'

  s.autorequire = "unit_record"
  s.files = FileList['{lib,test}/**/*.rb', 'CHANGELOG', 'README', 'Rakefile'].to_a
end

Rake::GemPackageTask.new(specification) do |package|
  package.need_zip = false
  package.need_tar = false
end

RUBY_VERSIONS = %w[1.8.5-p52 1.8.5-p114 1.8.6]
JRUBY_VERSIONS = %w[1.1b1 1.0.2]
RAILS_VERSIONS = %w[1.2.5 1.99.0 2.0.1]

namespace :test do
  desc "test with multiple versions of ruby and rails"
  task :multi do
    RUBY_VERSIONS.each do |ruby_version|
      bin = "/usr/local/ruby-#{ruby_version}/bin"
      RAILS_VERSIONS.each do |rails_version|
        sh "RAILS_VERSION='#{rails_version}' #{bin}/rake test > /dev/null 2>&1"
      end
    end      
  end
  
  desc "test with multiple versions of jruby and rails"
  task :multi_jruby do
    JRUBY_VERSIONS.each do |jruby_version|
      home = "/usr/local/jruby/jruby-#{jruby_version}"
      RAILS_VERSIONS.each do |rails_version|
        sh "JRUBY_HOME=#{home} RAILS_VERSION='#{rails_version}' #{home}/bin/rake test > /dev/null 2>&1"
      end
    end      
  end
end
