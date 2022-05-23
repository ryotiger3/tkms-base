class Order
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :product_id, :user_id, :token

  with_options presence: true do
    validates :token
    validates :user_id
    validates :product_id
    validates :city
    validates :address
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/}, length: { is: 8 }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :phone_number, format:  { with: /\A\d{10,11}\z/ }
  end


  def save
    purchase_history = PurchaseHistory.create(user_id: user_id, product_id: product_id)
    Destination.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, purchase_history_id: purchase_history.id)
  end

end