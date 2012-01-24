# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "activerecord-sqlanywhere-adapter"
  s.version     = "1.0.2"
  s.authors     = ["Eric Farrar", "Paul Smith"]
  s.email       = ["eric.farrar@ianywhere.com", "paul@elandesign.co.uk"]
  s.summary     = "ActiveRecord driver for SQL Anywhere"
  s.description = "ActiveRecord driver for SQL Anywhere"

  s.has_rdoc    = true
  s.rubyforge_project = 'sqlanywhere'
  s.homepage    = 'http://sqlanywhere.rubyforge.org'  
  s.files       = Dir['lib/**/*.rb'] + Dir['test/**/*']
  # s.required_ruby_version = '>= 1.9.2'
  s.require_paths = ['lib']
  s.add_dependency('sqlanywhere')
  s.add_dependency('activerecord')
  s.rdoc_options << '--title' << 'ActiveRecord Driver for SQL Anywhere' <<
                         '--main' << 'README' <<
                         '--line-numbers'
  s.extra_rdoc_files = ['README', 'CHANGELOG', 'LICENSE']

end
