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

class HorizontalFrameExample < FXMainWindow
  
  def initialize(app)
    super(app, "Horizontal Frame Example", :width => 400, :height => 200)

    hframe = FXHorizontalFrame.new(self)
    child1 = FXButton.new(hframe, "First")
    child2 = FXButton.new(hframe, "Second")
    child3 = FXButton.new(hframe, "Third")

  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  FXApp.new do |app|
    HorizontalFrameExample.new(app)
    app.create
    app.run
  end
end
