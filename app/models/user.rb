class User < ApplicationRecord
  attr_reader :activation_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save :email_downcase
  before_create :create_activation_digest

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

  has_secure_password

  class << self
    def digest string
      cost =
          if ActiveModel::SecurePassword.min_cost
            BCrypt::Engine::MIN_COST
          else
            BCrypt::Engine.cost
          end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"

    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def activate
    update_attributes activated: true
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def current_user? current_user
    self == current_user
  end

  private

  def email_downcase
    email.downcase!
  end

  def create_activation_digest
    @activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
