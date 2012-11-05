#class Cart
#  include Mongoid::Document
#  belongs_to :client_user
#end
require 'lib/cart_mongoid/active_cart_mongoid.rb'
class ShoppingCart < ActiveCart::StorageEngines::MongoidStorage
  include Mongoid::Document
  belongs_to :client_user
  # you must define the mongoid association to model the cart contents, e.g:
  embeds_many :accounts, :class_name => "Product"
  # optionally change which collection the carts are stored
  store_in :shopping_baskets
end
