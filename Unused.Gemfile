source 'https://rubygems.org'

gem 'rails', '~> 3.2.7'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'



# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'


group :test do

	#	Started getting 500 errors midway through testing.  These always
	#	occurred on testing "without login" tests.
	#		SystemStackError: stack level too deep
	#	Once this is "tripped", it always happens.
	#	I'm not really sure what the issue is, but reverting back to
	#	the mysql gem and hoping that this all goes away.
	#	While I could change the stack size with "ulimit -s",
	#	I'd rather understand what it taking up the space.
	#	Tests are supposed to clean up after themselves, but
	#	something is clearly not.
	#	mocha 0.11.4 seems to be the trigger
	#	Without the :lib => false, 'rake test' actually fails?
	gem "mocha", '0.10.5', :require => false #	0.11.4

end

gem 'jeweler'
