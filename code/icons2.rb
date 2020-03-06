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
    super(app, "What's That Spell?", :width => 350, :height => 100)
    container = FXMatrix.new(self, 4, :opts => MATRIX_BY_COLUMNS|PACK_UNIFORM_WIDTH|PACK_UNIFORM_HEIGHT|LAYOUT_CENTER_X|LAYOUT_CENTER_Y)

    r_icon = FXBMPIcon.new(app,
      File.open("Rasl.bmp", "rb").read,
      :opts => IMAGE_ALPHAGUESS)

    u_icon = FXBMPIcon.new(app, File.open("Uasl.bmp", "rb").read, :opts => IMAGE_ALPHAGUESS)
    b_icon = FXBMPIcon.new(app, File.open("Basl.bmp", "rb").read, :opts => IMAGE_ALPHAGUESS)
    y_icon = FXBMPIcon.new(app, File.open("Yasl.bmp", "rb").read, :opts => IMAGE_ALPHAGUESS)
    FXLabel.new(container, nil, r_icon, :opts => LAYOUT_CENTER_X|LAYOUT_CENTER_Y)
    FXLabel.new(container, nil, u_icon, :opts => LAYOUT_CENTER_X|LAYOUT_CENTER_Y)
    FXLabel.new(container, nil, b_icon, :opts => LAYOUT_CENTER_X|LAYOUT_CENTER_Y)
    FXLabel.new(container, nil, y_icon, :opts => LAYOUT_CENTER_X|LAYOUT_CENTER_Y)
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
