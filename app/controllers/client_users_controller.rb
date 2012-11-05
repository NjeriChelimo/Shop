class ClientUsersController < ApplicationController
  # GET /client_users
  # GET /client_users.json
  def index
    @client_users = ClientUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @client_users }
    end
  end

  # GET /client_users/1
  # GET /client_users/1.json
  def show
    @client_user = ClientUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client_user }
    end
  end

  # GET /client_users/new
  # GET /client_users/new.json
  def new
    @client_user = ClientUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client_user }
    end
  end

  # GET /client_users/1/edit
  def edit
    @client_user = ClientUser.find(params[:id])
  end

  # POST /client_users
  # POST /client_users.json
  def create
    @client_user = ClientUser.new(params[:client_user])

    respond_to do |format|
      if @client_user.save
        format.html { redirect_to @client_user, notice: 'Client user was successfully created.' }
        format.json { render json: @client_user, status: :created, location: @client_user }
      else
        format.html { render action: "new" }
        format.json { render json: @client_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /client_users/1
  # PUT /client_users/1.json
  def update
    @client_user = ClientUser.find(params[:id])

    respond_to do |format|
      if @client_user.update_attributes(params[:client_user])
        format.html { redirect_to @client_user, notice: 'Client user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_users/1
  # DELETE /client_users/1.json
  def destroy
    @client_user = ClientUser.find(params[:id])
    @client_user.destroy

    respond_to do |format|
      format.html { redirect_to client_users_url }
      format.json { head :no_content }
    end
  end
end
