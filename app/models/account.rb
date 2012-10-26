class Account
  include Mongoid::Document
  field :name, type: String
  field :organization_id, type: String
  field :org_id, type: Integer
  field :mpayer_id, type: Integer
  field :ac_type, type: String
  field :acid, type: String
  field :balance, type: String
  field :mandate, type: String
  field :currency, type: String
  field :total_cr, type: String
  field :total_dr, type: String
  has_many :images
  validates_presence_of :ac_type
  belongs_to :organization
  attr_accessible :name, :organization_id, :ac_type, :acid, :balance, :mandate, :currency, :total_cr, :total_dr
end
