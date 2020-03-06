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

class PackerExample < FXMainWindow
  
  def initialize(app)
    super(app, "Packer Example", :width => 400, :height => 200)
    packer = FXPacker.new(self, :opts => LAYOUT_FILL)

    child1 = FXButton.new(packer, "First",
      :opts => BUTTON_NORMAL|LAYOUT_SIDE_BOTTOM|LAYOUT_CENTER_X)

  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  FXApp.new do |app|
    PackerExample.new(app)
    app.create
    app.run
  end
end
