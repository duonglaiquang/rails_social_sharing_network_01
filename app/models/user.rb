class User < ApplicationRecord
  attr_reader :activation_token, :reset_token
  attr_accessor :remember_token
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

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
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

  def forget
    update_attribute :remember_digest, nil
  end

  def create_reset_digest
    @reset_token = User.new_token
    update_attributes reset_digest: User.digest(reset_token),
      updated_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    updated_at < Setting.max_timing.hours.ago
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

  private

  def email_downcase
    email.downcase!
  end

  def create_activation_digest
    @activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
