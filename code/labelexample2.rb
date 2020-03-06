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
    super(app, "Labels", :width => 300, :height => 50)
    label = FXLabel.new(self, "Bottom and right-justified text", :opts => LAYOUT_FILL)

    label.justify = JUSTIFY_RIGHT|JUSTIFY_BOTTOM

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