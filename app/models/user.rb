class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable, :omniauthable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :actions, as: :target
  has_many :notifications, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
           foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
           foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :email, format: {with: VALID_EMAIL_REGEX}, presence: true,
            length: {maximum: Settings.max_email},
            uniqueness: {case_sensitive: false}

  validates :name, presence: true, length: {maximum: Settings.max_name}

  validates :password, allow_nil: true, presence: true,
            length: {minimum: Settings.min_password}

  class << self
    def from_omniauth auth
      where(provider: auth.provider,
            uid: auth.uid).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = SecureRandom.hex(8) if user.new_record?
        user.name = auth.info.name
        user.save
        user
      end
    end
  end

  def current_user? current_user
    self == current_user
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end
end
