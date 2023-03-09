class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, allow_blank: true

  validates :nickname, :last_name, :first_name, :last_kana, :first_kana, :birth, presence: true

  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }, allow_blank: true do
    validates :last_name
    validates :first_name
  end

  with_options format: { with: /\A[ァ-ヶー]+\z/ }, allow_blank: true do
    validates :last_kana
    validates :first_kana
  end
end
