class CartItem
  include Mongoid::Document
  belongs_to :cart
  has_one :account
  field :cart_id
  field :name
  field :price
  field :quantity
  field :subtotal
  attr_accessible :cart_id, :name, :price, :quantity, :subtotal
end
