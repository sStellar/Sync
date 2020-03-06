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

class KeyboardEventsExample < FXMainWindow
  
  def initialize(app)
    super(app, "Keyboard Events", :width => 300, :height => 300)
    
    self.enable
    
    code = FXDataTarget.new("")
    alt = FXDataTarget.new(false)
    capslock = FXDataTarget.new(false)
    control = FXDataTarget.new(false)
    meta = FXDataTarget.new(false)
    numlock = FXDataTarget.new(false)
    scrolllock = FXDataTarget.new(false)

    shift = FXDataTarget.new(false)


    code_frame = FXHorizontalFrame.new(self, LAYOUT_FILL_X)
    FXLabel.new(code_frame, "Event Code: ")
    FXTextField.new(code_frame, 8, :target => code, :selector => FXDataTarget::ID_VALUE)
    
    FXHorizontalSeparator.new(self, SEPARATOR_GROOVE|LAYOUT_FILL_X)

    FXCheckButton.new(self, "ALTMASK", :target => alt, :selector => FXDataTarget::ID_VALUE)
    FXCheckButton.new(self, "CAPSLOCKMASK", :target => capslock, :selector => FXDataTarget::ID_VALUE)
    FXCheckButton.new(self, "CONTROLMASK", :target => control, :selector => FXDataTarget::ID_VALUE)
    FXCheckButton.new(self, "METAMASK", :target => meta, :selector => FXDataTarget::ID_VALUE)
    FXCheckButton.new(self, "NUMLOCKMASK", :target => numlock, :selector => FXDataTarget::ID_VALUE)
    FXCheckButton.new(self, "SCROLLLOCKMASK", :target => scrolllock, :selector => FXDataTarget::ID_VALUE)

    FXCheckButton.new(self, "SHIFTMASK", :target => shift, :selector => FXDataTarget::ID_VALUE)

    

    self.connect(SEL_KEYPRESS) do |sender, sel, event|

      code.value = event.code.to_s
      alt.value = (event.state & ALTMASK) != 0
      capslock.value = (event.state & CAPSLOCKMASK) != 0
      control.value = (event.state & CONTROLMASK) != 0
      meta.value = (event.state & METAMASK) != 0
      numlock.value = (event.state & NUMLOCKMASK) != 0
      scrolllock.value = (event.state & SCROLLLOCKMASK) != 0

      shift.value = (event.state & SHIFTMASK) != 0
    end

    
    self.connect(SEL_KEYRELEASE) do |sender, sel, event|
      code.value = event.code.to_s
      alt.value = (event.state & ALTMASK) != 0
      capslock.value = (event.state & CAPSLOCKMASK) != 0
      control.value = (event.state & CONTROLMASK) != 0
      meta.value = (event.state & METAMASK) != 0
      numlock.value = (event.state & NUMLOCKMASK) != 0
      scrolllock.value = (event.state & SCROLLLOCKMASK) != 0
      shift.value = (event.state & SHIFTMASK) != 0
    end
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  FXApp.new do |app|
    KeyboardEventsExample.new(app)
    app.create
    app.run
  end
end
