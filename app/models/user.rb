class User
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :organization
  field :mpayer_user_no, :type => String
  field :mpayer_user_id, :type => String
  field :organization_id, :type => String
  field :token, :type => String
    attr_accessible :mpayer_user_no, :mpayer_user_id, :role, :name, :organization_id, :token

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

  index({ email: 1 }, { unique: true, background: true })
  field :name, :type => String
  validates_presence_of :name
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :created_at, :updated_at


  def mpayer_authenticate(user, password)
    user = user
    password = password
    form_data = "user=#{@user}&password=#{@password}"
    link = "https://ec2-72-44-42-20.compute-1.amazonaws.com/api/login.json"
    url = URI.parse("#{link}")
    request = send_post_request("#{link}", url.path, form_data)
  end

  def synchronize_mpayer(user, password)
    response = mpayer_authenticate(user, password)
    user_details = JSON.parse(response)
  end

  def send_get_request(request_domain,path,data,headers=nil)
    uri = URI.parse(request_domain)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    if headers == nil
      response = http.send_request('GET',path,data)
    else
      response = http.send_request('GET',path,data,headers)
    end

    response.body
  end

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

end
