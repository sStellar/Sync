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

class SimpleKeyboardEventsExample < FXMainWindow
  
  def initialize(app)
    super(app, "Keyboard Events", :width => 300, :height => 300)
    self.enable
    
    code_frame = FXHorizontalFrame.new(self, LAYOUT_FILL_X)
      FXLabel.new(code_frame, "Code: ")
      code_text = FXTextField.new(code_frame, 8)
    FXHorizontalSeparator.new(self, SEPARATOR_GROOVE|LAYOUT_FILL_X)
    shift_check = FXCheckButton.new(self, "Shift")
    
    # The key goes down...

    self.connect(SEL_KEYPRESS) do |sender, sel, event|

      code_text.text = event.code.to_s

      shift_check.checkState = (event.state & SHIFTMASK) != 0
    end

    
    # ... and the key comes back up
    self.connect(SEL_KEYRELEASE) do |sender, sel, event|
      code_text.text = event.code.to_s
      shift_check.checkState = (event.state & SHIFTMASK) != 0
    end
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  FXApp.new do |app|
    SimpleKeyboardEventsExample.new(app)
    app.create
    app.run
  end
end
