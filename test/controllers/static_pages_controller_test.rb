require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get root_url
    assert_response :success
    assert_select "title", "Odin Facebook"
  end

  test "should get about" do
    get about_url
    assert_response :success
    assert_select "title", "About | Odin Facebook"
  end

end
