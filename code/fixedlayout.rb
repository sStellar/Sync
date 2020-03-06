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

class FixedLayoutExample < FXMainWindow
  def initialize(app)
    super(app, "Fixed Layout Example", :width => 400, :height => 200)

    @fixed_pos_button = FXButton.new(self, "Fixed Position",
      :opts => BUTTON_NORMAL|LAYOUT_FIX_X|LAYOUT_FIX_Y,
      :x => 20, :y => 20)


    @fixed_size_label = FXLabel.new(self, "Fixed Size Label",
      :opts => (LAYOUT_CENTER_X|LAYOUT_CENTER_Y|
                LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT),
      :width => 120, :height => 40)

    @fixed_size_label.frameStyle = FRAME_LINE
    spinner_frame = FXHorizontalFrame.new(self, :opts => LAYOUT_SIDE_BOTTOM|LAYOUT_CENTER_X)
    font_size_label = FXLabel.new(spinner_frame, "Font Size:")
    @font_size_spinner = FXSpinner.new(spinner_frame, 6, :opts => SPIN_NORMAL)
    @font_size_spinner.setIncrement(10)
    @font_size_spinner.range = 10..480
    @font_size_spinner.connect(SEL_COMMAND) do |sender, sel, value|
      font_description = @fixed_size_label.font.fontDesc
      font_description.size = sender.value
      font = FXFont.new(app, font_description)
      font.create
      @fixed_size_label.font = font
    end
  end
  
  def create
    super
    @font_size_spinner.value = @fixed_size_label.font.size
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    FixedLayoutExample.new(app)
    app.create
    app.run
  end
end