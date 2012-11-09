class CartItem
  include Mongoid::Document
  belongs_to :cart
  belongs_to :account
  has_many :accounts
  field :cart_id
  field :name
  attr_accessible :cart_id, :name
end
