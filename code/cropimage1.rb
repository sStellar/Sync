#---
# Excerpted from "FXRuby: Create Lean and Mean GUIs with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fxruby for more book information.
#---
require 'fox16'

include Fox

class CropImageExample < FXMainWindow
  
  def initialize(app)
    super(app, "Cropped Image Example", :width => 575, :height => 425)

    @image = FXJPGImage.new(app,
      File.open("birdsnest.jpg", "rb").read,
      :opts => IMAGE_KEEP)

    @image_frame = FXImageFrame.new(self, @image, :opts => FRAME_SUNKEN|FRAME_THICK|LAYOUT_CENTER_X|LAYOUT_CENTER_Y)
  end
  
  def create
    super

    @image.crop(0, 0, 0.5*@image.width, 0.5*@image.height)

    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  FXApp.new do |app|
    CropImageExample.new(app)
    app.create
    app.run
  end
end
