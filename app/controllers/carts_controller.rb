class CartsController < ApplicationController
  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carts }
    end
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    @cart = Cart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /carts/new
  # GET /carts/new.json
  def new
    @cart = Cart.new
    @item_name = params[:itemName]
    @item_price = params[:itemPrice]
    @item_qty = params[:itemQty]
    @item_subtotal = params[:itemTotal]
    @cart_item = @cart.cart_items.new ({:name => @item_name, :price => @item_price, :subtotal => @itemsubtotal})
    @cart.save!

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart }
    end
  end



  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(params[:cart])
    @item_name = params[:itemName]
    @item_price = params[:itemPrice]
    @item_qty = params[:itemQty]
    @item_subtotal = params[:itemTotal]
    @cart_item = @cart.cart_items.build({:name => @item_name, :price => @item_price, :subtotal => @item_subtotal})


    respond_to do |format|
      if @cart.save
        @cart_item.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render json: @cart, status: :created, location: @cart }
      else
        format.html { render action: "new" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.json
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_url }
      format.json { head :no_content }
    end
  end
end
