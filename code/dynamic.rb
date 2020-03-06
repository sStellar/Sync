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

class DynamicExample < FXMainWindow
  
  def initialize(app)
    super(app, "Dynamically Added Widgets", :width => 300, :height => 400)
    top = FXHorizontalFrame.new(self, LAYOUT_FILL_X)
    FXHorizontalSeparator.new(self, SEPARATOR_GROOVE|LAYOUT_FILL_X)
    contents = FXMatrix.new(self, 2, MATRIX_BY_COLUMNS|LAYOUT_FILL)
    add_button = FXButton.new(top, "Add a Row", :opts => BUTTON_NORMAL|LAYOUT_CENTER_X)
    add_button.connect(SEL_COMMAND) do

      FXLabel.new(contents, "Dynamically Added Field")
      FXTextField.new(contents, 20)
      contents.create # create server-side resources
      contents.recalc # mark parent layout as dirty

    end
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  FXApp.new do |app|
    DynamicExample.new(app)
    app.create
    app.run
  end
end
