require "test_helper"

ApplicationController.validate_all = false
#ApplicationController.check_urls = true	#	Sorry, won't work in rails 3, yet
ApplicationController.check_redirects = true

class Html::Test::IntegrationTest < ActionController::IntegrationTest
	def test_assert_validates_invokes_all
		get('/test/valid')
		assert_response :success

#		[:tidy_errors, :w3c_errors, :xmllint_errors].each do |method|
		[:w3c_errors, :xmllint_errors].each do |method|
			Html::Test::Validator.expects(method).with(@response.body)
		end
#		assert_validates
		assert_w3c
		assert_xmllint
skip "Not using or testing tidy"
	end

	def test_assert_tidy_invoked
		get('/test/valid')
		assert_response :success
skip "Not using or testing tidy"
		Html::Test::Validator.expects(:tidy_errors).with(@response.body)
		assert_tidy
	end
	
	def test_assert_valid_success
		get('/test/valid')
		assert_response :success
#		assert_validates
		assert_w3c
		assert_xmllint
skip "Not using or testing tidy"
	end

	def test_assert_tidy_failure
		file_string = TestController.test_file_string(:untidy)
#		assert_raise(Test::Unit::AssertionFailedError) do
skip "Not using or testing tidy"
		assert_raise(MiniTest::Assertion) do
			assert_tidy(file_string)
		end
		assert_w3c(file_string)
		assert_xmllint(file_string)
	end
	
	def test_assert_w3c_failure
		file_string = TestController.test_file_string(:invalid)
#	These "assert_raise(Test::Unit::AssertionFailedError)" are negative assertions
#	and are a bit irritating. Basically says that the assertion in the block
#	will fail.
#		assert_raise(Test::Unit::AssertionFailedError) do
		assert_raise(MiniTest::Assertion) do
			assert_w3c(file_string)
		end
#		assert_raise(Test::Unit::AssertionFailedError) do
		assert_raise(MiniTest::Assertion) do
			assert_xmllint(file_string)
		end
#		assert_raise(Test::Unit::AssertionFailedError) do
#		assert_raise(MiniTest::Assertion) do
#	I don't see the purpose of this test
#			Html::Test::Validator.expects(:dtd).returns("doctype")
#			assert_xmllint(file_string)
#		end		
skip "Not using or testing tidy"
		assert_tidy(file_string)
	end
	
	def test_url_no_route
skip "ActionController::Routing::Routes doesn't exist in Rails 3"
		TestController.any_instance.expects(:rescue_action).with() { |e| e.class == Html::Test::InvalidUrl }
		get '/test/url_no_route'
	end

	def test_url_no_route_relative
skip "ActionController::Routing::Routes doesn't exist in Rails 3"
		TestController.any_instance.expects(:rescue_action).with() { |e| e.class == Html::Test::InvalidUrl }
		get '/test/url_no_route_relative'
	end
	
	def test_redirect_valid_action
		get '/test/redirect_valid_action'
		assert_response :redirect
	end
end
