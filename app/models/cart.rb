class Cart
  include Mongoid::Document
  has_many :cart_items
  has_and_belongs_to_many :accounts
  belongs_to :client_user
  field :client_user_id
  attr_accessible :client_user_id
end
