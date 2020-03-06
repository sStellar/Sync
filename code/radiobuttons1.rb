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

class RadioButtonsWindow < FXMainWindow
  
  def initialize(app)
    super(app, "Radio Buttons", :width => 200, :height => 100, :padding => 10)
    
    groupbox = FXGroupBox.new(self, "Options",
      :opts => GROUPBOX_NORMAL|FRAME_GROOVE|LAYOUT_FILL_X|LAYOUT_FILL_Y)
    
    
    @radio1 = FXRadioButton.new(groupbox, "Good Enough")
    
    
    @radio1.connect(SEL_COMMAND) { @choice = 0 }
    
    
    @radio2 = FXRadioButton.new(groupbox, "Perfect")
    
    
    @radio2.connect(SEL_COMMAND) { @choice = 1 }
    

    
    @choice = 0
    @radio1.checkState = true
    
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

end

if __FILE__ == $0
  
  FXApp.new do |app|
    RadioButtonsWindow.new(app)
    app.create
    app.run
  end
  
end