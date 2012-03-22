module Html
	module Test
		class ValidateFilter
			attr_accessor :request, :response, :params, :validators
			
			include ::Test::Unit::Assertions
			include ::Html::Test::Assertions

			def initialize(controller)
				self.request = controller.request
				self.response = controller.response
				self.params = controller.params
				self.validators = controller.class.validators
			end

			def validate_page
#				url = request.request_uri
#	no more request_uri in Rails 3
				url = request.url
				return if (!should_validate? || ValidateFilter.already_validated?(url))
#				assert_validates(validators, response.body.strip, url, :verbose => true)
				assert_validates(validators, response.body.strip, url )
				ValidateFilter.mark_url_validated(url)
			end

			def self.already_validated?(url)
				if Html::Test::Validator.revalidate_all
					false
				else
					validated_urls[url]
				end
			end

			def self.mark_url_validated(url)
				validated_urls[url] = true				
			end

			def self.validated_urls
				@validated_urls ||= {}
			end

			# Override this method if you only want to validate a subset of pages
			def should_validate?
#				response.status =~ /200/ &&
#         (response.headers['Content-Type'] =~ /text\/html/i || response.body =~ /<html/)
#	In rails 3, 
#		response.status is a Fixnum which would return nil in this match
#		and response.headers['Content-Type'] is blank
				response.status.to_s =~ /200/ &&
					(response.content_type =~ /text\/html/i || response.body =~ /<html/)
			end			

			#	Used in testing (of html_test_extension plugin)
			#	to remove the validated_urls hash
			#	so can test with the same url.
			def self.clear_validated_urls
				@validated_urls = {}
			end

		end
	end
end
