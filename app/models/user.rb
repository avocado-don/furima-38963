class User < ApplicationRecord
  has_many :items
  has_many :orders

  #あえてvalidatesを複数回に分けて記述：入力欄の順序と、エラーメッセージの表示順序を揃えることで、ユーザーが直感的に理解しやすい表示にしたい。(記述者補足)
  validates :nickname, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, allow_blank: true

  validates :first_name, :last_name, presence: true
  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }, allow_blank: true do
    validates :first_name
    validates :last_name
  end

  validates :first_kana, :last_kana, presence: true
  with_options format: { with: /\A[ァ-ヶー]+\z/ }, allow_blank: true do
    validates :first_kana
    validates :last_kana
  end

  validates :birth, presence: true
end
