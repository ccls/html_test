module Html
	module Test
		module Assertions
			def assert_tidy(body = nil)
				assert_validates(:tidy, body)
			end

			def assert_w3c(body = nil)
				assert_validates(:w3c, body)
			end
			
			def assert_xmllint(body = nil)
				assert_validates(:xmllint, body)
			end

			def assert_validates(types = nil, body = nil, url = nil, options = {})
				verbose = ( options[:verbose] ) ? options[:verbose] : Html::Test::Validator.verbose
				body ||= @response.body
				types ||= [:tidy, :w3c, :xmllint]
				types = [types] if !types.is_a?(Array)
				types.each do |t|
					log("validating #{url} with #{t} ... ") if verbose
					error = Html::Test::Validator.send("#{t}_errors", body)
					if error.nil?
						log("OK\n") if verbose
					else
						log("FAILURE\n") if verbose
						assert_message = "Validator #{t} failed"
						assert_message << " for url #{url}" if url
						assert_message << " with message '#{error}'"

#	Why would I want to print this in the log file???
#						Rails.logger.error(assert_message + " for response body:\n #{with_line_counts(body)}")
						assert(error.nil?, assert_message)
					end
				end
			end
			
			private
			def log(message)
				print(message)
			end
			
			def with_line_counts(body)
				separator = ("-" * 40) + $/
				body_counts = separator.dup
				#	string no longer responds to each_with_index in ruby 1.9.3
				#	body.each_with_index do |line, i|
				body.split(/\n/).each_with_index do |line, i|
					body_counts << sprintf("%4u %s", i+1, line) # Right align line numbers
				end
				body_counts << separator
				body_counts
			end
		end
	end
end
