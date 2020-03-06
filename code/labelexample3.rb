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

class LabelExample < FXMainWindow
  def initialize(app)
    super(app, "Labels", :width => 350, :height => 250)
    p = FXVerticalFrame.new(self, :opts => LAYOUT_CENTER_X|LAYOUT_CENTER_Y|PACK_UNIFORM_WIDTH, :vSpacing => 10)

    line_frame = FXLabel.new(p, "Line Frame", :opts => FRAME_LINE)


    sunken_framed_label = FXLabel.new(p, "Sunken Frame")
    sunken_framed_label.frameStyle = FRAME_SUNKEN

    raised_frame = FXLabel.new(p, "Raised Frame", :opts => FRAME_RAISED)
    groove_frame = FXLabel.new(p, "Groove Frame", :opts => FRAME_GROOVE)
    ridge_frame = FXLabel.new(p, "Ridge Frame", :opts => FRAME_RIDGE)
    sunken_thick_frame = FXLabel.new(p, "Sunken and Thick Frame", :opts => FRAME_RAISED|FRAME_THICK)
    raised_thick_frame = FXLabel.new(p, "Raised and Thick Frame", :opts => FRAME_SUNKEN|FRAME_THICK)
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    LabelExample.new(app)
    app.create
    app.run
  end
end