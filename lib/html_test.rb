#if !defined?(RAILS_ENV) || RAILS_ENV == 'test'
if !defined?(RAILS_ENV) || RAILS_ENV == 'test' || Rails.env == 'test'

	%w(validator assertions url_selector url_checker link_validator validate_filter).each do |file|
		require File.join(File.dirname(__FILE__), file)
	end
	
	class Test::Unit::TestCase
		include Html::Test::Assertions
	end
	
	module ActionController
		module Integration #:nodoc:
			class Session
				include Html::Test::Assertions			
			end
		end
	end
	
#	ActionController::Base
	require 'action_controller'
	class ActionController::Base
		@@validate_all = false
		cattr_accessor :validate_all
	
		@@validators = [:tidy]
		cattr_accessor :validators
	
		@@check_urls = false
		cattr_accessor :check_urls
	
		@@check_redirects = false
		cattr_accessor :check_redirects
	
		after_filter :validate_page
		after_filter :check_urls_resolve
		after_filter :check_redirects_resolve
	
		private
		def validate_page
			return if !validate_all
			Html::Test::ValidateFilter.new(self).validate_page
		end
	
		def check_urls_resolve
			return if !check_urls
			Html::Test::UrlChecker.new(self).check_urls_resolve
		end
	
		def check_redirects_resolve
			return if !check_redirects
			Html::Test::UrlChecker.new(self).check_redirects_resolve
		end
	end




validate = false
validators = ["http://localhost/w3c-validator/check", 
							Html::Test::Validator.w3c_url]

validators.each do |validator|
	vhost = validator.split('/')[2]
	vpath = "/"<< validator.split('/')[3..-1].join('/')
	begin
		response = Net::HTTP.get_response(vhost, vpath)
		if response.code == '200'
			Html::Test::Validator.w3c_url = validator
			validate = true
			break
		end
	rescue
	end
end

if validate
#	In Rails 3, ApplicationController not defined yet
#	ApplicationController.validate_all = true
	ActionController::Base.validate_all = true
	#       default is :tidy, but it doesn't really validate.       
	#       I've purposely not closed tags and it doesn't complain.
	#       :w3c is ridiculously slow! even when used locally
#	ApplicationController.validators = [:w3c]
#	In Rails 3, ApplicationController not defined yet
	ActionController::Base.validators = [:w3c]
	#ApplicationController.validators = [:tidy, :w3c]
	Html::Test::Validator.verbose = false
	Html::Test::Validator.revalidate_all = true
	Html::Test::Validator.tidy_ignore_list = 
		[/<table> lacks "summary" attribute/]
	puts "Validating all html with " <<
		Html::Test::Validator.w3c_url
else
	puts "NOT validating html at all"
end

end	#if !defined?(RAILS_ENV) || RAILS_ENV == 'test'
