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
         :omniauthable, omniauth_providers: [:facebook]

  # Friendship relationships
  has_many :sent_friendships, class_name: "Friendship",
                              foreign_key: "sender_id",
                              dependent: :destroy

  has_many :received_friendships, class_name: "Friendship",
                                  foreign_key: "receiver_id",
                                  dependent: :destroy
  
  has_many :sent_friends,            -> { where("accepted=?", true)},  through: :sent_friendships,     source: :receiver
  has_many :received_friends,        -> { where("accepted=?", true)},  through: :received_friendships, source: :sender
  has_many :sent_friend_invites,     -> { where("accepted=?", false)}, through: :sent_friendships,     source: :receiver
  has_many :received_friend_invites, -> { where("accepted=?", false)}, through: :received_friendships, source: :sender

  # Post relationships
  has_many :posts, dependent: :destroy

  # Like relationships
  has_many :likes, dependent: :destroy

  # Comments
  has_many :comments, dependent: :destroy

  def accepted_friends
    friends = []
    self.sent_friends.each do |friend|
      friends << friend
    end
    self.received_friends.each do |friend|
      friends << friend
    end
    friends
  end

  def sent_requests
    friends = []
    self.sent_friend_invites.each do |friend|
      friends << friend
    end
    friends
  end

  def received_requests
    friends = []
    self.received_friend_invites.each do |friend|
      friends << friend
    end
    friends
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.save!
    end
  end

  private
  	
    def downcase_email
  		email.downcase!
  	end
end
