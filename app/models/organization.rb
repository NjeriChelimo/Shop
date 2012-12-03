class Organization
  include Mongoid::Document
  has_many :accounts
  has_one :users
  has_many :client_users
  field :org_no, type: String
  field :name
  attr_accessible :org_no, field :name
end
