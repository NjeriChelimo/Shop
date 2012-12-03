

class Mpayer
  @@root_url = "https://ec2-72-44-42-20.compute-1.amazonaws.com/api"
  attr_accessor :user_no, :token, :ref_id, :headers

  def initialize(user_no, token, ref_id = Time.now.to_i)
    @user_no = user_no
    @token = token
    @ref_id = ref_id
    @headers = {'Content-Type'=>'application/json','X-WSSE' => WSSE::header(user_no, token)}
  end

  def transaction(*opts)
    opts = opts
    Transaction.new(@user_no, @token, Time.now.to_i)
  end

  def client(*opts)
    Client.new(@user_no, @token, Time.now.to_i)
  end

  def mpayer_account(*opts)
    MpayerAccount.new(@user_no, @token, Time.now.to_i )
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

  def send_put_request(request_domain,path,data,headers=nil)
    uri = URI.parse(request_domain)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    if headers == nil
      response = http.send_request('PUT',path,data)
    else
      response = http.send_request('PUT',path,data,headers)
    end

    response.body
  end

  def send_delete_request(request_domain,path,data,headers=nil)
    uri = URI.parse(request_domain)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    if headers == nil
      response = http.send_request('DELETE',path,data)
    else
      response = http.send_request('DELETE',path,data,headers)
    end

    response.body
  end

  def send_request(domain, request_type, request_path, data={}, headers={})
    request_path = "/#{request_path}" unless request_path[0] == "/"
    data = data.to_query if data.is_a?(Hash)
    response = {}
    if request_type == "GET"
      response = send_get_request(domain, request_path, data, headers)
    elsif request_type == "POST"
      response = send_post_request(domain, request_path, data, headers)
    elsif request_type == "PUT"
      response = send_put_request(domain, request_path, data, headers)
    elsif request_type == "DELETE"
      response = send_delete_request(domain, request_path, data, headers)
    end
  end

end

class Transaction < Mpayer

  def initialize(*args)
    super
  end

  def find(tran_id)
    id = tran_id
    link ="/transactions/#{@id}"
    url = URI.parse("#{@@root_url}#{@link}")
    send_get_request("#{@@root_url}#{@link}", url.path, "", headers)
  end

  def all_trans
    link ="/transactions/all.json"
    url = URI.parse("#{@@root_url}#{@link}")
    send_get_request("#{@@root_url}#{@link}", url.path, "", headers)
  end

  def deposit(json_msg)
    json_msg = JSON.generate(json_msg)
    link ="/transactions/deposit.json"
    url = URI.parse("#{@@root_url}#{@link}")
    send_put_request("#{@@root_url}#{@link}", url.path, json_msg, headers)
  end

  def withdraw(json_msg)
    json_msg = JSON.generate(json_msg)
    link ="/transactions/withdraw.json"
    url = URI.parse("#{@@root_url}#{@link}")
    send_delete_request("#{@@root_url}#{@link}", url.path, json_msg, headers)
  end

  def transfer(json_msg)
    json_msg_transfer = JSON.generate(json_msg)
    link ="/transactions/transfer.json"
    url = URI.parse("#{@@root_url}#{@link}")
    send_post_request("#{@@root_url}#{@link}", url.path, json_msg_transfer, headers)
  end
end

class Client < Mpayer
  attr_accessor :user_no, :token, :ref_id, :headers
  def initialize(*args)
    super
  end

  def all_clients
    link ="/clients/all_clients.json"
    url = URI.parse("#{@@root_url}#{@link}")
    send_get_request("#{@@root_url}#{@link}", url.path, "", headers)
  end

  def new_client(json_msg)
    json_msg = JSON.generate(json_msg)
    link ="/clients.json"
    url = URI.parse("#{@@root_url}#{@link}")
    send_post_request("#{@@root_url}#{@link}", url.path, json_msg, headers)
  end

  def mpayer_accounts
    link ="/clients/#{@id}/accounts"
    url = URI.parse("#{@@root_url}#{@link}")
    send_get_request("#{@@root_url}#{@link}", url.path, "", headers)
  end


  def find_account(account_id)
    account_id = account_id
    link ="/clients/#{@id}/accounts/#{@account_id}"
    url = URI.parse("#{@@root_url}#{@link}")
    send_get_request("#{@@root_url}#{@link}", url.path, "", headers)
  end

  def trans(ac_id)
    account_id = ac_id
    link ="/clients/#{@id}/accounts/#{@account_id}/transactions"
    url = URI.parse("#{@@root_url}#{@link}")
    send_get_request("#{@@root_url}#{@link}", url.path, "", headers)
  end

  def trans_sets(ac_id)
    account_id = ac_id
    link ="/clients/#{@id}/accounts/#{@account_id}/transaction_sets"
    url = URI.parse("#{@@root_url}#{@link}")
    send_get_request("#{@@root_url}#{@link}", url.path, "", headers)
  end

  def find_tran(ac_id, tran_id)
    account_id = ac_id
    tran_id = tran_id
    link ="/clients/#{@id}/accounts/#{@account_id}/transactions/#{@tran_id}"
    url = URI.parse("#{@@root_url}#{@link}")
    send_get_request("#{@@root_url}#{@link}", url.path, "", headers)
  end

  def payables
    @link ="/clients/#{@id}/payables"
    url = URI.parse("#{@@root_url}#{@link}")
    send_get_request("#{@@root_url}#{@link}", url.path, "", headers)
  end

  def find_payable(payable_id)
    payable = payable_id
    @link ="/clients/#{@id}/payables/#{@payable_id}"
    url = URI.parse("#{@@root_url}#{@link}")
    send_get_request("#{@@root_url}#{@link}", url.path, "", headers)
  end

  def new_account(json_msg)
    json_msg = json_msg
    json_msg = JSON.generate(json_msg)
    link ="/clients/#{@id}/accounts/new"
    url = URI.parse("#{@@root_url}#{@link}")
    send_post_request("#{@@root_url}#{@link}", url.path, json_msg, headers)
  end
end

class MpayerAccount < Mpayer
  attr_accessor :user_no, :token, :ref_id, :headers
  def initialize(*args)
    super
  end

  def all_accounts
    @link ="/accounts/all_accounts.json"
    url = URI.parse("#{@@root_url}#{@link}")
    send_get_request("#{@@root_url}#{@link}", url.path, "", headers)
  end

  def find_account(id)
    id = id
    @link ="/accounts/#{@id}.json"
    url = URI.parse("#{@@root_url}#{@link}")
    send_get_request("#{@@root_url}#{@link}", url.path, "", headers)
  end
end

=begin
#IMPLEMENTATION
#njeri = Mpayer.new("NC0014","7DHeBCt9Ka6337owqDSn")
#t = njeri.transaction
#trans = t.trans
dep = tran.dep(args)
=end
