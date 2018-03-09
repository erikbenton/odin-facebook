class Friendship < ApplicationRecord

	belongs_to :sender
	belongs_to :receiver

	validates :sender_id, 	presence: true
	validates :receiver_id, presence: true
end
