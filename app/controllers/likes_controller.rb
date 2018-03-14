class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
  	@like = Like.new(like_params)
  	if @like.save
  		flash[:success] = "You have liked that post"
  		redirect_to user_path(like_params[:user_id])
  	else
  		flash[:danger] = "Unable to like that post"
  		redirect_to user_path(like_params[:user_id])
  	end
  end

  def destroy
  	@user_page = Like.find(params[:id]).post.user
  	Like.find(params[:id]).destroy
  	flash[:success] = "You have unlike that post"
  	redirect_to user_path(@user_page)
  end

  def like_params
  	params.require(:like).permit(:post_id, :user_id)
  end
end
