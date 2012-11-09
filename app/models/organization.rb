class Organization
  include Mongoid::Document
  has_many :accounts
  has_many :users
  field :org_no, type: String
  attr_accessible :org_no
end
