class Cart
  include Mongoid::Document
  belongs_to :client_user
  has_many :cart_items
  field :client_user_id
  attr_accessible :client_user_id
end
