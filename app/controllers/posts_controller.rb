class PostsController < ApplicationController

	def create
		@post = current_user.post.create!(post_params)
	end

	def update		
	end

	def destroy
	end

	private

		def post_params
			params.require(:post).permit(:content)
		end
end
