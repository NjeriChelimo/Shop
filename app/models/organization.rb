class Organization
  include Mongoid::Document
  has_many :accounts
  field :name, type: String
  attr_accessible :name
end
