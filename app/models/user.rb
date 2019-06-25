class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: %i(github)
  attr_writer :postcode1, :postcode2
  before_validation :set_postcode
  validates :postcode, format: { with: /\A\d{3}[-]\d{4}\z/, message: "の入力内容を確認してください" }, allow_blank: true
  validates :name, presence: true
  has_many :books, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy
  paginates_per 10
  has_one_attached :avatar
  has_many :active_relationships, class_name: "Friendship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Friendship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships
  validate :avatar_validation


  def postcode1
    @postcode1 ||= postcode.present? ? postcode.split("-").first : nil
  end

  def postcode2
    @postcode2 ||= postcode.present? ? postcode.split("-").last : nil
  end

  def self.find_for_github_oauth(auth, signed_in_resource = nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    unless user
      user = User.new(name:     auth.info.name,
                      provider: auth.provider,
                      uid:      auth.uid,
                      email:    auth.info.email,
                      password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      user.save
    end
    user
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private

  def set_postcode
    self.postcode = postcode1.present? || postcode2.present? ? [postcode1, postcode2].join("-") : nil
  end

  def avatar_validation
    if avatar.attached?
      if avatar.blob.byte_size > 10.megabytes
        avatar.purge
        errors.add(:avatar, :max_size_error, max_size: "10MB")
      elsif !avatar.blob.content_type.starts_with?("image/")
        avatar.purge
        errors.add(:avatar, :content_type_error)
      end
    end
  end
end
