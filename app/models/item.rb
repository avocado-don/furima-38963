class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  validates :image, :name, :description, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 10_000_000 }, allow_blank: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :ship_fee
  belongs_to :ship_day
  belongs_to :prefecture

  validates :category_id, :condition_id, :ship_fee_id, :ship_day_id, :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
end
