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

class ScrollWindowExample < FXMainWindow
  def initialize(app)
    super(app, "ScrollWindow Example", :width => 400, :height => 400)
    center_button = FXButton.new(self, "Hop to Center", :opts => BUTTON_NORMAL|LAYOUT_CENTER_X|LAYOUT_SIDE_BOTTOM)
    center_button.connect(SEL_COMMAND) do

      x = 0.5*(@scroll_window.contentWindow.width -
        @scroll_window.viewportWidth)
      y = 0.5*(@scroll_window.contentWindow.height -
        @scroll_window.viewportHeight)
      @scroll_window.setPosition(-x, -y)

    end
    @scroll_window = FXScrollWindow.new(self, :opts => LAYOUT_FILL)
    @canvas = FXCanvas.new(@scroll_window, :opts => LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT)
    @canvas.connect(SEL_PAINT) do |sender, sel, event|
      FXDCWindow.new(sender, event) do |dc|
        dc.drawImage(@blue_marble, 0, 0)
      end
    end
   @blue_marble = FXJPGImage.new(app, open("http://veimages.gsfc.nasa.gov/2429/globe_west_2048.jpg", "rb").read)
  end
  
  def create
    super
    @blue_marble.create
    @canvas.width = @blue_marble.width
    @canvas.height = @blue_marble.height
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    ScrollWindowExample.new(app)
    app.create
    app.run
  end
end