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

class IconsWindow < FXMainWindow
  
  def initialize(app)
    super(app, "Colored Shapes", :width => 600, :height => 150)
    container = FXMatrix.new(self, 3, :opts => MATRIX_BY_COLUMNS|LAYOUT_CENTER_X|LAYOUT_CENTER_Y)
    opaque_icon = FXBMPIcon.new(app, File.open("shapes.bmp", "rb").read)
    guess_transp = FXBMPIcon.new(app, File.open("shapes.bmp", "rb").read, :opts => IMAGE_ALPHAGUESS)

    red_transp = FXBMPIcon.new(app,
      File.open("shapes.bmp", "rb").read,
      :opts => IMAGE_ALPHACOLOR)
    red_transp.transparentColor = FXRGB(255, 0, 0)

    FXLabel.new(container, nil, opaque_icon, :opts => ICON_ABOVE_TEXT|LAYOUT_CENTER_X)
    FXLabel.new(container, nil, guess_transp, :opts => ICON_ABOVE_TEXT|LAYOUT_CENTER_X)
    FXLabel.new(container, nil, red_transp, :opts => ICON_ABOVE_TEXT|LAYOUT_CENTER_X)
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  FXApp.new do |app|
    IconsWindow.new(app)
    app.create
    app.run
  end
end
