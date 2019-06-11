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

  private

  def set_postcode
    self.postcode = postcode1.present? && postcode2.present? ? [postcode1, postcode2].join("-") : nil
  end
end
