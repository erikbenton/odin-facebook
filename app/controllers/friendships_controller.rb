class FriendshipsController < ApplicationController
	before_action :authenticate_user!

	def create
		@friendship = Friendship.create!(friendship_params)
	end

	def destroy

	end

	def accept
		@friendship = Friendship.find_by(friendship_params)
		@friendship.accepted = true
		if @friendship.save
			flash[:success] = "You have just accepted a friend =)"
			redirect_to notifications_user_url(current_user.id)
		else
			flash[:danger] = "You were unable to become their friend =("
			redirect_to root_url
		end
	end

	def friendship_params
		params.require(:friendship).permit(:sender_id, :receiver_id)
	end

end
