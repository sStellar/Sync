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

class ColorDialogExample < FXMainWindow
  def initialize(app)
    super(app, "Color Dialog Example", :width => 300, :height => 100)
    color_btn = FXButton.new(self, "Choose Background Color...", :opts => BUTTON_NORMAL|LAYOUT_CENTER_X)
    color_btn.connect(SEL_COMMAND) do

      dialog = FXColorDialog.new(self, "Choose Background Color")
      dialog.rgba = FXRGB(255, 0, 0) # initialize color to red
      if dialog.execute != 0
        self.backColor = dialog.rgba
      end

    end
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    ColorDialogExample.new(app)
    app.create
    app.run
  end
end
