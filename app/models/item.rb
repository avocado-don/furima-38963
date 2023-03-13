class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  #あえてvalidatesを複数回に分けて記述：入力欄の順序と、エラーメッセージの表示順序を揃えることで、ユーザーが直感的に理解しやすい表示にしたい。(記述者補足)
  validates :image, :name, :description, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :ship_fee
  belongs_to :ship_day
  belongs_to :prefecture

  validates :category_id, :condition_id, :ship_fee_id, :prefecture_id, :ship_day_id, numericality: { other_than: 0, message: "を選択してください" }

  validates :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }, allow_blank: true
end
