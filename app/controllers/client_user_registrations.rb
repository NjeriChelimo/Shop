class ClientUserRegistrationsController < Devise::RegistrationsController
  def new
    #super
    @client_user = ClientUser.new
      respond_to do |format|
        format.html # new.html.haml
        format.json { render :json => @client_user }
    end
  end

  def create
    @client_user = ClientUser.new(params[:client_user])
    respond_to do |format|
      if @client_user.save!
        sign_in(@client_user)
        format.html { redirect_to root_url }
        format.json { render :json => @user, status: :created, location: @admin_user }
      else
        format.html { render action: "new" }
        format.json { render :json => @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    super
  end
end
