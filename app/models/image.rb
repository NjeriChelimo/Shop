class Image
  include Mongoid::Document
  include Mongoid::Paperclip
  field :image_file_name
  field :crop_x
  field :crop_y
  field :crop_w
  field :crop_h
  field :account_id#, type: Integer
  field :organization_id#, type: Integer
  has_mongoid_attached_file :image, :styles => { :small => "100x100#", :large => "500x500>" }, :processors => [:cropper],
    :path => ":rails_root/public/system/image/:id/:style/:basename.:extension",
    :url  => "/system/image/:id/:style/:basename.:extension"
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes

  belongs_to :accounts
  attr_accessible :account_id, :organization_id, :image
  attr_accessible :crop_x, :crop_y, :crop_w, :crop_h, :image_file_name
  after_update :reprocess_avatar, :if => :cropping?

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def image_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(image.path(style))
  end

  private

  def reprocess_image
    image.reprocess!
  end
end
