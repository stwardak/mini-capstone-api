class CartedProduct < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :user
  has_many :products
end
