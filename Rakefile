require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the html_test plugin.'
Rake::TestTask.new(:test) do |t|
	t.libs << 'lib'
	t.pattern = 'test/**/*_test.rb'
	t.verbose = true
end

desc 'Generate documentation for the html_test plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
	rdoc.rdoc_dir = 'rdoc'
	rdoc.title		= 'HtmlTest'
	rdoc.options << '--line-numbers' << '--inline-source'
	rdoc.rdoc_files.include('README')
	rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
	require 'jeweler'
	Jeweler::Tasks.new do |gem|
		gem.name = "ccls-html_test"
		gem.summary = %Q{Ruby on Rails plugin for HTML validation and link checking}
		gem.description = %Q{Ruby on Rails plugin for HTML validation and link checking}
		gem.email = "github@jakewendt.com"
		gem.homepage = "http://github.com/ccls/html_test"
		gem.authors = ["Peter Marklund", "George 'Jake' Wendt"]
		# gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
	end
	Jeweler::GemcutterTasks.new
rescue LoadError
	puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
