class Cart
  include Mongoid::Document
  has_many :cart_items
  belongs_to :client_user
  field :client_user_id
  field :total_price
  field :total_items
  field :payable_no
  field :payable_id
  attr_accessible :client_user_id, :total_price, :total_items
end
