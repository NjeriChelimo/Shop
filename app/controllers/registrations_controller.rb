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
    @user_details = @user.synchronize_mpayer(@user.name, @user.password)
    @mpayer_user_id = @user_details[:user_id]
    @mpayer_user_no = @user_details[:user_no]
    @mpayer_user_name = @user_details[:user_name]
    @mpayer_user_role = @user_details[:user_role]
    @user_update = {:name => @mpayer_user_name, :mpayer_user_id => @mpayer_user_id, :mpayer_user_no => @mpayer_user_no, :role => @mpayer_user_role}
    if @user.update_attributes(params[:@user_update])
      @org_no = @user_details[:org_no]
      @org = Organization.new({:org_no => @org_no, :user_id => @user.id})
  #    @mpayer = Mpayer.new(@mpayer_user_no, @decrypted_token)
  #    @ac = @mpayer.account
  #    @accounts = @ac.all_accounts
  #    @acs = JSON.parse(@accounts)
  #    @ac.each do |a|
  #      @org.accounts.create!(a)
  #    end
      @user.save!
      #super
    end
#      respond_to do |format|
#        if @user.save
#          format.html { redirect_to root_url, notice: 'User was successfully created.' }
#          format.json { render :json => @user, status: :created, location: @admin_user }
#        else
#          format.html { render action: "new" }
#          format.json { render :json => @user.errors, status: :unprocessable_entity }
#        end
  end

  def update
    super
  end
end
