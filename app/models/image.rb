class Image
  include Mongoid::Document
  include Mongoid::Paperclip
  field :name, type: String
  field :account_id#, type: Integer
  field :organization_id#, type: Integer
  has_mongoid_attached_file :image, :styles => { :small => "100x100#", :large => "500x500>" }, :processors => [:cropper]
  belongs_to :accounts
  attr_accessible :name, :account_id, :organization_id, :image
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
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
