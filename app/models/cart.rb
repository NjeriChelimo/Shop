class Cart
  include Mongoid::Document
  has_many :cart_items
  has_many :accounts, :through => :cart_items
  belongs_to :client_user
  field :client_user_id
  attr_accessible :client_id
end
