class CartItem
  include Mongoid::Document
  belongs_to :cart
  field :cart_id
  field :name
  attr_accessible :cart_id, :name
end
