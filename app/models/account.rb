class Account
  include Mongoid::Document
  field :name, type: String
  field :organization_id, type: Integer
  has_many :images
  belongs_to :organization
  attr_accessible :name, :organization_id
end
