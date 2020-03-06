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

class ImagesWindow < FXMainWindow
  
  def initialize(app)
    super(app, "Mirror Image Example", :width => 600, :height => 500)
    frame = FXVerticalFrame.new(self, :opts => LAYOUT_FILL, :padTop => 20)
    @image = FXJPGImage.new(app,
      File.open("birdsnest.jpg", "rb").read,
      :opts => IMAGE_KEEP)
    @image_frame = FXImageFrame.new(frame, @image, :opts => FRAME_SUNKEN|FRAME_THICK|LAYOUT_CENTER_X)
    FXHorizontalSeparator.new(frame, :opts => LAYOUT_FILL_X|SEPARATOR_GROOVE)
    @horz_mirror = FXCheckButton.new(frame, "Mirror Horizontal", :padLeft => 12)
    @horz_mirror.connect(SEL_COMMAND) do |sender, sel, data|
      @image.mirror(true, false)
      @image_frame.update
    end
    @vert_mirror = FXCheckButton.new(frame, "Mirror Vertical", :padLeft => 12)
    @vert_mirror.connect(SEL_COMMAND) do |sender, sel, data|

      @image.mirror(false, true)

      @image_frame.update
    end
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  FXApp.new do |app|
    ImagesWindow.new(app)
    app.create
    app.run
  end
end
