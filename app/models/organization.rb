class Organization
  include Mongoid::Document
  has_many :accounts
  has_many :users
  field :org_no, type: String
  field :account_id, type: String
  field :user_id, type: String
  attr_accessible :org_no, :user_id, :account_id
end
