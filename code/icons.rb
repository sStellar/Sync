#---
# Excerpted from "FXRuby: Create Lean and Mean GUIs with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fxruby for more book information.
#---
require 'fox16'

require 'open-uri'



include Fox

class IconsWindow < FXMainWindow
  
  def initialize(app)
    super(app, "Icons Demo", :width => 600, :height => 450)
    container = FXMatrix.new(self, 2, :opts => MATRIX_BY_COLUMNS|LAYOUT_CENTER_X)

    gif_icon = FXGIFIcon.new(app, File.open("fxruby.gif", "rb").read)

    FXLabel.new(container, "An FXGIFIcon", gif_icon, :opts => ICON_ABOVE_TEXT|LAYOUT_CENTER_X)

    png_icon = FXPNGIcon.new(app, File.open("fxruby.png", "rb").read)

    FXLabel.new(container, "An FXPNGIcon constructed\nwithout IMAGE_ALPHAGUESS", png_icon, :opts => ICON_ABOVE_TEXT|LAYOUT_CENTER_X)

    jpg_icon = FXJPGIcon.new(app,
      File.open("fxruby.jpg", "rb").read,
      :opts => IMAGE_ALPHAGUESS)

    FXLabel.new(container, "An FXJPGIcon constructed\nwith IMAGE_ALPHAGUESS", jpg_icon, :opts => ICON_ABOVE_TEXT|LAYOUT_CENTER_X)

    jpg_icon = FXJPGIcon.new(app,
      File.open("fxruby.jpg", "rb").read,
      :clr => FXRGB(0, 0, 0), # Make black pixels transparent
      :opts => IMAGE_ALPHACOLOR)

    FXLabel.new(container, "An FXJPGIcon constructed\nwith specified transparency color", jpg_icon, :opts => ICON_ABOVE_TEXT|LAYOUT_CENTER_X)
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
