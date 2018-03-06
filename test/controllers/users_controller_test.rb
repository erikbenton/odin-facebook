require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get show" do
    @user = User.create(name: "Erik", email: "email@example.com", password: "password")
    get user_url(@user.id)
    assert_response :success
  end
end
