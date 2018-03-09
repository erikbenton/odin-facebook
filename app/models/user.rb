class User < ApplicationRecord

	before_save :downcase_email
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :sent_friendships, class_name: "Friendship",
                              foreign_key: "sender_id",
                              dependent: :destroy

  has_many :received_friendships, class_name: "Friendship",
                                  foreign_key: "acceptor_id",
                                  dependent: :destroy

  private
  	def downcase_email
  		email.downcase!
  	end
end
