#---
# Excerpted from "FXRuby: Create Lean and Mean GUIs with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fxruby for more book information.
#---
class PhotoView < FXImageFrame
  
  MAX_WIDTH  = 200
  MAX_HEIGHT = 200

  def initialize(p, photo)
    super(p, nil)
    load_image(photo.path)
  end

  def load_image(path)
    File.open(path, "rb") do |io|
      self.image = FXJPGImage.new(app, io.read)
      scale_to_thumbnail
    end
  end

  def scaled_width(width)
    [width, MAX_WIDTH].min
  end
  
  def scaled_height(height)
    [height, MAX_HEIGHT].min
  end

  def scale_to_thumbnail
    aspect_ratio = image.width.to_f/image.height
    if image.width > image.height
      image.scale(
        scaled_width(image.width),
        scaled_width(image.width)/aspect_ratio,
        1
      )
    else
      image.scale(
        aspect_ratio*scaled_height(image.height),
        scaled_height(image.height),
        1
      )
    end
  end
end
