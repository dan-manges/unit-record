# this file is generated by rake gemspec:generate for github
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{unit_record}
  s.version = "0.9.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dan Manges"]
  s.autorequire = %q{unit_record}
  s.date = %q{2015-05-29}
  s.description = %q{UnitRecord enables unit testing without hitting the database.}
  s.email = %q{daniel.manges@gmail.com}
  s.files = Dir['lib/**/*rb'].concat(['CHANGELOG', 'LICENSE', 'README.md'])
  s.homepage = %q{http://unit-test-ar.rubyforge.org}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{unit-test-ar}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{UnitRecord enables unit testing without hitting the database.}
  s.add_development_dependency 'rake', '> 0'
  s.add_development_dependency 'dust', '0.1.6'
  s.add_development_dependency 'test-unit', '3.1.1'
  s.add_development_dependency 'rspec', '1.1.11'
  s.add_development_dependency 'mocha', '1.1.0'

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
