# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'rake/clean'

CLEAN.include "**/#*.*#"

Hoe.plugin :bundler

  Hoe.plugin :bundler
# Hoe.plugin :compiler
# Hoe.plugin :gem_prelude_sucks
# Hoe.plugin :gem_prelude_sucks
# Hoe.plugin :inline
# Hoe.plugin :inline
# Hoe.plugin :racc
# Hoe.plugin :racc
# Hoe.plugin :rcov
# Hoe.plugin :rcov
# Hoe.plugin :rubyforge
# Hoe.plugin :rubyforge

Hoe.spec 'ometa' do

  developer('Dominic Sisneros', 'dsisnero@gmail.com')
  # extra_deps << ['blah', '~> 1.0']
  # extra_dev_deps << ['blah', '~>1.0']
  # dependency(name,version,type)  :type one of :[:runtime, :dev,
  # :development, :developer]
  dependency('hoe-bundler', '> 0.0.0', :dev)
  dependency('rspec', '> 0.0.0', :dev)
  dependency('ZenTest', '> 0.0.0', :dev)
  dependency('cucumber', '> 0.0.0', :dev)
  dependency('aruba', '> 0.0.0', :dev)
  dependency('concord', '> 0.0.0')
  dependency('abstract_type', '> 0.0.0')
  dependency('monadic', '> 0.0.0')
  license 'MIT'

  ##
  # Optional: Extra files you want to add to RDoc.
  #
  # .txt files are automatically included (excluding the obvious).

  # extra_rdoc_files

  ##
  # Optional: The filename for the project history. [default: History.txt]

  # history_file


  # self.rubyforge_name = 'ometa' # if different than 'ometa'
end
