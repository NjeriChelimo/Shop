class Image
  include Mongoid::Document
  include Mongoid::Paperclip
  field :price
  field :discount
  field :description, type: String
  field :picture_file_name
  field :crop_x
  field :price
  field :description
  field :deal
  field :crop_y
  field :crop_w
  field :crop_h
  field :account_id#, type: Integer
  field :organization_id#, type: Integer
  has_mongoid_attached_file :picture, :styles => { :small => "100x100#", :large => "250x250>" }, :processors => [:cropper],
#    :path => ":rails_root/public/system/image/:id/:style/:basename.:extension",
#    :url  => "/system/image/:id/:style/:basename.:extension"

    :url => "/assets/images/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/images/:id/:style/:basename.:extension"

  validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 5.megabytes

  belongs_to :accounts
  attr_accessible :account_id, :organization_id, :picture
  attr_accessible :crop_x, :crop_y, :crop_w, :crop_h, :picture_file_name, :deal, :description, :price
  #before_update :reprocess_picture

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def picture_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(picture.path(style))
  end

  #private

  def reprocess_picture
    picture.reprocess!
  end
end
