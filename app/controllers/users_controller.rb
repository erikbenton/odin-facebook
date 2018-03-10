class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  	@users = User.all
  	@friendship = Friendship.new
  end

  def show
    @user = User.find(params[:id])
  end

  def notifications
  	@user = User.find(params[:id])
  	@friend_invites = @user.received_friend_invites
  	@pending_invites = @user.sent_friend_invites
  	@friendship = Friendship.new
  	render 'show_notifications'
  end
end
