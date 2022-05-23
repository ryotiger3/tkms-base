class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
   belongs_to :category
   belongs_to :shipping_days
   belongs_to :user
   has_one :purchase_history
   has_one_attached :image

 with_options presence: true do
   validates :image
   validates :name
   validates :description
   validates :category_id
   validates :shipping_days_id
   validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
 end

  validates :category_id, :shipping_days_id, numericality: { other_than: 1 }

end
