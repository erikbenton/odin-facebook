require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
  	@user = User.create!(name: "Erik Benton",
												 email: 'erik@example.com',
												 password: 'password',
												 password_confirmation: 'password')
  	@post = Post.new(content: "Testing one two three", user_id: @user.id)
  end

  test 'should be valid' do
  	assert @post.valid?
  end

  test 'user id should be present' do
  	@post.user_id = nil
  	assert_not @post.valid?
  end
end
