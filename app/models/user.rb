class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  attr_writer :postcode1, :postcode2
  before_validation :set_postcode
  validates :postcode, presence: true, format: { with: /\A\d{3}[-]\d{4}\z/, message: "の入力内容を確認してください" }
  validates :name, presence: true
  validates :address, presence: true
  validates :biography, presence: true
  has_many :books
  has_many :reports
  has_many :comments

  def postcode1
    @postcode1 ||= postcode.present? ? postcode.split("-").first : nil
  end

  def postcode2
    @postcode2 ||= postcode.present? ? postcode.split("-").last : nil
  end

  private

  def set_postcode
    self.postcode = postcode1.present? && postcode2.present? ? [postcode1, postcode2].join("-") : nil
  end
end
