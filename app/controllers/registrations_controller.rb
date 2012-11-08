class RegistrationsController < Devise::RegistrationsController
  def new
    #super
    @admin_user = User.new
      respond_to do |format|
        format.html # new.html.haml
        format.json { render :json => @user }
    end
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      @user_details = @user.synchronize_mpayer(@user.name, @user.password)
      @mpayer_user_id = @user_details["user_id"]
      @token = @user_details["token"]
      @decrypted_token = Base64.decode64(@token)
      @mpayer_user_no = @user_details["user_no"]
      @mpayer_user_name = @user_details["user_name"]
      @mpayer_user_role = @user_details["user_role"]
      @user_update = {:name => @mpayer_user_name, :mpayer_user_id => @mpayer_user_id, :mpayer_user_no => @mpayer_user_no, :role => @mpayer_user_role}
      if @user.save!
        if @user.update_attributes(@user_update)
          @org_no = @user_details["org_no"]
          @org = Organization..find_or_create_by({:org_no => @org_no})
          @user.update_attributes({:organization_id => @org.id})
          @user.save!
          @mpayer = Mpayer.new(@mpayer_user_no, @decrypted_token)
          @ac = @mpayer.mpayer_account
          @accounts = @ac.all_accounts
          @acs = JSON.parse(@accounts)
          @acs.each do |a|
            @ac = @org.accounts.create!(a)
          end
        end
        sign_in(@user)
        format.html { redirect_to root_url }
        format.json { render :json => @user, status: :created, location: @admin_user }
      else
        format.html { render action: "new" }
        format.json { render :json => @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def sync_mpayer
    @user = User.find(params[:id])
    @user_details = @user.synchronize_mpayer(@user.name, @user.password)
    @mpayer_user_id = @user_details["user_id"]
    @token = @user_details["token"]
    @decrypted_token = Base64.decode64(@token)
    @mpayer_user_no = @user_details["user_no"]
    @mpayer_user_name = @user_details["user_name"]
    @mpayer_user_role = @user_details["user_role"]
    @user_update = {:name => @mpayer_user_name, :mpayer_user_id => @mpayer_user_id, :mpayer_user_no => @mpayer_user_no, :role => @mpayer_user_role}
    respond_to do |format|
      if @user.update_attributes(@user_update)
        @org_no = @user_details["org_no"]
        @org = Organization.create!({:org_no => @org_no})
        @user.update_attributes({:organization_id => @org.id})
        @user.save!
        format.html { redirect_to root_url, notice: 'User was successfully created.' }
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
