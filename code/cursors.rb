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

class CursorsWindow < FXMainWindow
  
  def initialize(app)
    super(app, "Cursors Demo", :width => 400, :height => 300)
    frame = FXVerticalFrame.new(self, LAYOUT_FILL_X|LAYOUT_CENTER_Y, :vSpacing => 10)

    box = FXLabel.new(frame, "Gimme Five!",
      :width => 40, :height => 40,
      :opts => LAYOUT_CENTER_X, :padding => 40)

    box.frameStyle = FRAME_GROOVE
    box.backColor = FXRGB(255, 0, 0)
    box.textColor = FXRGB(255, 255, 255)

    box.defaultCursor = app.getDefaultCursor(DEF_HAND_CURSOR)


    box = FXLabel.new(frame,
      "Who's a Programmer's Best Friend?",
      :width => 40, :height => 40,
      :opts => LAYOUT_CENTER_X, :padding => 40)

    box.frameStyle = FRAME_GROOVE
    box.backColor = FXRGB(0, 0, 255)
    box.textColor = FXRGB(255, 255, 255)

    custom_cursor = FXGIFCursor.new(app,
      File.open("rubycursor.gif", "rb").read)
    custom_cursor.create
    box.defaultCursor = custom_cursor

  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  FXApp.new do |app|
    CursorsWindow.new(app)
    app.create
    app.run
  end
end
