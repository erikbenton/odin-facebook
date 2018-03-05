require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@erik = User.new(name: "Erik", email: "erik@example.com", password: "foo123")
  end

  test 'should be valid' do
  	assert @erik.valid?
  end

  test 'should downcase email' do
  	mixed_case_email = "WeLcOME@emaIL.CoM"
  	@erik.email = mixed_case_email
  	@erik.save
  	assert_equal mixed_case_email.downcase, @erik.reload.email
  end

end
