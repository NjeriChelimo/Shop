class CartItem
  include Mongoid::Document
  include ActiveCart::Items::MongoidItem

  # a cart item will always contain a product
  embeds_one :account
  embedded_in :ShoppingCart, :inverse_of => :accounts

  # you need to override the construtor to ensure the cart item's ID represents the product's ID. otherwise, the cart will always think you are adding a different product and will never increment quantity.
  def initialize(account)
    attrs = {
      :id => account.id,
      :product => product
    }
    super(attrs)
  end

  # this should return the price as it will be serialised in the basket collection, e.g. pence/cents
  def price
    product.price
  end
end
