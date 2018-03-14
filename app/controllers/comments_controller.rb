class CommentsController < ApplicationController

	before_action :authenticate_user!

	def create
		@comment = Comment.new(comment_params)

		if @comment.save
			flash[:success] = "Comment created"
			redirect_to user_url(comment_params[:user_id])
		else
			flash[:danger] = "Unable to create comment"
			redirect_to user_url(comment_params[:user_id])
		end
	end

	def destroy
		@user_page = Comment.find(params[:id]).post.user
  	Comment.find(params[:id]).destroy
  	flash[:success] = "You have deleted that comment"
  	redirect_to user_path(@user_page)
	end

	private

		def comment_params
			params.require(:comment).permit(:user_id, :content, :post_id)
		end

end
