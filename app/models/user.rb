class User
  include Mongoid::Document
  rolify
  #resourcify
  include Mongoid::Timestamps

  belongs_to :organization
  #field :name, :type => String
  field :mpayer_user_no, :type => String
  field :mpayer_user_id, :type => String
  field :organization_id, :type => String
  field :token, :type => String
    attr_accessible :mpayer_user_no, :mpayer_user_id, :role, :name, :organization_id, :token

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  field :role,               :type => String, :default => ""

  validates_presence_of :email
  validates_presence_of :encrypted_password

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  # run 'rake db:mongoid:create_indexes' to create indexes
  index({ email: 1 }, { unique: true, background: true })
  field :name, :type => String
  validates_presence_of :name
  attr_accessible :role_ids, :as => :admin
  #attr_protected :role
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :created_at, :updated_at


  def send_post_request(request_domain,path,data,headers=nil)
    uri = URI.parse(request_domain)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    if headers == nil
      response = http.send_request('POST',path,data)
    else
      response = http.send_request('POST',path,data,headers)
    end
    response.body
  end

  def mpayer_authenticate(user, password)
    @user = user
    @password = password
    @form_data = "user=#{@user}&password=#{@password}"
    @link = "https://ec2-72-44-42-20.compute-1.amazonaws.com/api/login.json"
    @url = URI.parse("#{@link}")
    @request = send_post_request("#{@link}", @url.path, @form_data)
  end

  def check_authentication?(response)
    @res_status = response.code
    if @res_status == "200"
      return true
    else
      return false
    end
  end

  def parse_response
    if check_authentication?
      @user_details = JSON.parse(@res_body)
    end
  end

  def decrypt_token
    #TODO finish the decrypting
    @json_res = parse_response
    @token = @user_details["token"]
    #@decrypted_token =
    @decrypted_token = Base64.decode64(@token)
  end

  def create_org
    @org_no = @user_details[:org_no]
    @org = Organization.create!({:org_no => @org_no})
  end

  def fetch_accounts
    @mpayer_user_id = @user_details[:user_id]
    @mpayer_user_no = @user_details[:user_no]
    @mpayer_user_name = @user_details[:user_name]
    @mpayer_user_role = @user_details[:user_role]
    @user = Mpayer.new(@mpayer_user_no, @decrypted_token)
    @ac = @user.account
    @accounts = @ac.all_accounts
  end

  def update_user(user)
    user.update_attributes({:name => @mpayer_user_name, :mpayer_user_id => @mpayer_user_id, :mpayer_user_no => @mpayer_user_no, :role => @mpayer_user_role})
  end

  def create_accounts
    @acs = JSON.parse(@accounts)
    @ac.each do |a|
      @org.accounts.create!(a)
    end
  end

  def synchronize_mpayer(user, password)
    @response = mpayer_authenticate(user, password)
    #if check_authentication?(@response)
    @user_details = JSON.parse(@response)
    return @user_details
  end

#  def mpayer_authenticated(user, password)
#    mpayer_authenticate(user, password)
#    if check_authentication?
#      @user_details = JSON.parse(@res_body)
#      @token = @user_details[:token]
#      #TODO Kariuki to show decrypting method again
#      @decrypted_token =
#      @mpayer_org_name = @user_details[:org_name]
#      @mpayer_org_no = @user_details[:org_no]
#      @mpayer_user_id = @user_details[:user_id]
#      @mpayer_user_no = @user_details[:user_no]
#      @mpayer_user_name = @user_details[:user_name]
#      @mpayer_user_role = @user_details[:user_role]
#      #create organization => incomplete. Add user_id
#      @org = Organization.create!({:name => @mpayer_org_name, :mpayer_org_no => @mpayer_org_no})
#      #TODO fetch accounts using gem => not implemented
#      @user = Mpayer.new(@mpayer_user_no, @decrypted_token)
#      @ac = @user.account
#      @accounts = @ac.all_accounts
#      @acs = JSON.parse(@accounts)
#      #store accounts in MongoDB
#      @ac.each do |a|
#        @org.accounts.create!(a)
#      end
#    else
#      return false
#    end
#  end
end
