class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def update_cart
    @user = current_client_user
    @cart = @user.carts.create!
    @item_name = params[:itemName]
    @item_price = params[:itemPrice]
    @item_qty = params[:itemQty]
    @item_subtotal = params[:itemTotal]
    @cart_item = @cart.cart_items.create!({:name => @item_name, :price => @item_price, :subtotal => @itemsubtotal})
    respond_to do |format|
      format.json
    end
  end

end
