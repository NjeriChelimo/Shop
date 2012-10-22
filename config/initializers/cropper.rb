#module Paperclip
#  class Cropper < Thumbnail
#    def transformation_command
#      if crop_command
#        crop_command + super.first.sub(/ -crop \S+/, '')
#      else
#        super
#      end
#    end

#    def crop_command
#      target = @attachment.instance
#      if target.cropping?
#        " -crop '#{target.crop_w.to_i}x#{target.crop_h.to_i}+#{target.crop_x.to_i}+#{target.crop_y.to_i}'"
#      end
#    end
#  end
#end


module Paperclip
  class ManualCropper < Thumbnail
    def initialize(file, options = {}, attachment = nil)
      super
      @current_geometry.width  = target.crop_w
      @current_geometry.height = target.crop_h
    end
    def target
      @attachment.instance
    end
    def transformation_command
      crop_command = [
        "-crop",
        "#{target.crop_w}x" \
          "#{target.crop_h}+" \
          "#{target.crop_x}+" \
          "#{target.crop_y}",
        "+repage"
      ]
      crop_command + super
    end
  end
end

#module Paperclip
#  class Cropper < Thumbnail
#    def transformation_command
#      if crop_command
#        crop_command + super.join(' ').sub(/ -crop \S+/, '').split(' ') # super returns an array like this: ["-resize", "100x", "-crop", "100x100+0+0", "+repage"]
#      else
#        super
#      end
#    end

#    def crop_command
#      target = @attachment.instance
#      if target.cropping?
#        ["-crop", "#{target.crop_w}x#{target.crop_h}+#{target.crop_x}+#{target.crop_y}"]
#      end
#    end
#  end
#end
