require "test_helper"

class Html::Test::ValidateAllTest < ActionController::TestCase
	def setup
		@controller = TestController.new
#		@request    = ActionController::TestRequest.new
#		@response   = ActionController::TestResponse.new
#		ApplicationController.validate_all = true
#		ApplicationController.validators = [:tidy]
	end

	def test_validate_all
#		assert_raise(Test::Unit::AssertionFailedError) { get :untidy }
	end
end
__END__

I don't use "tidy" so I don't test "tidy".

