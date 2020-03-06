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

    @choice = FXDataTarget.new(0)

    groupbox = FXGroupBox.new(self, "Options", :opts => GROUPBOX_NORMAL|FRAME_GROOVE|LAYOUT_FILL_X|LAYOUT_FILL_Y)

    radio1 = FXRadioButton.new(groupbox, "Good Enough",
      :target => @choice, :selector => FXDataTarget::ID_OPTION)
    radio2 = FXRadioButton.new(groupbox, "Perfect",
      :target => @choice, :selector => FXDataTarget::ID_OPTION+1)


    @choice.connect(SEL_COMMAND) do
      puts "The newly selected value is #{@choice.value}"
    end

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