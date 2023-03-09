class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :post_code, :prefecture_id, :city, :street, :building, :phone_num

  validates :user_id, :item_id, :token, :post_code, presence: true

  validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }, allow_blank: true

  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  validates :city, :street, :phone_num, presence: true

  validates :phone_num, format: { with: /\A[0-9]{10,11}\z/ }, allow_blank: true

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(order_id: order.id, post_code: post_code, prefecture_id: prefecture_id, city: city, street: street, building: building, phone_num: phone_num)
  end
end
