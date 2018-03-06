require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@erik = User.new(username: "Erik", email: "erik@example.com", password: "foo123")
  end

  test 'should be valid' do
  	assert @erik.valid?
  end

  test "user name should be present" do
  	@erik.name = "      "
  	assert_not @erik.valid?
  end

  test "user password should be present" do
  	@erik.password = "     "
  	assert_not @erik.valid?
  end

  test "user password need to be at least 6 characters" do
  	@erik.password = "12345"
  	assert_not @erik.valid?
  	@erik.password = "123456"
  	assert @erik.valid?
  end

  test 'should downcase email' do
  	mixed_case_email = "WeLcOME@emaIL.CoM"
  	@erik.email = mixed_case_email
  	@erik.save
  	assert_equal mixed_case_email.downcase, @erik.reload.email
  end

  test 'emails should be unique' do
  	@erik.save
  	@user2 = User.new(name: "Other", email: "erik@example.com", password: "foo123")
  	assert_not @user2.valid?
  end

end
