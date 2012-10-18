class Image
  include Mongoid::Document
  include Mongoid::Paperclip
  field :name, type: String
  field :account_id#, type: Integer
  field :organization_id#, type: Integer
  has_mongoid_attached_file :image
  belongs_to :accounts
  attr_accessible :name, :account_id, :organization_id, :image
end
