class FriendshipsController < ApplicationController

	def create
		@friendship = Friendship.create!(friendship_params)
	end

	def destroy

	end

	def accept
		
	end

	def friendship_params
		params.require(:friendship).permit(:sender_id, :receiver_id)
	end

end
