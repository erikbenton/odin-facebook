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
                                  foreign_key: "receiver_id",
                                  dependent: :destroy
  
  has_many :sent_friends, -> { where("accepted=?", true)}, through: :sent_friendships, source: :receiver
  has_many :received_friends, -> { where("accepted=?", true)}, through: :received_friendships, source: :sender

  def all_friends
    friends = []
    self.sent_friends.each do |friend|
      friends << friend
    end
    self.received_friends.each do |friend|
      friends << friend
    end
    friends
  end

  private
  	def downcase_email
  		email.downcase!
  	end
end
