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

class FontDialogExample < FXMainWindow
  def initialize(app)
    super(app, "Font Dialog Example", :width => 300, :height => 100)
    button = FXButton.new(self, "Choose Font...", :opts => BUTTON_NORMAL|LAYOUT_CENTER_X)
    button.connect(SEL_COMMAND) do

      dialog = FXFontDialog.new(self, "Choose a Font")
      dialog.fontSelection = button.font.fontDesc
      if dialog.execute != 0
        new_font = FXFont.new(app, dialog.fontSelection)
        new_font.create
        button.font = new_font
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
    FontDialogExample.new(app)
    app.create
    app.run
  end
end
