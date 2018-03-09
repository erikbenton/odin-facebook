class Friendship < ApplicationRecord

	validates :sender_id, 	presence: true
	validates :acceptor_id, presence: true

end
