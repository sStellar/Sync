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

class MatrixExample < FXMainWindow
  
  def initialize(app)
    super(app, "Matrix Layout Example", :width => 300, :height => 150)

    matte = FXPacker.new(self, :opts => LAYOUT_FILL)
    matte.backColor = "red"
    matrix = FXMatrix.new(matte, 3,
      :opts => MATRIX_BY_COLUMNS|LAYOUT_FILL, :padding => 20)

    FXLabel.new(matrix, "Lyle Johnson", :opts => JUSTIFY_LEFT|FRAME_LINE|LAYOUT_FILL_X)
    FXLabel.new(matrix, "Madison", :opts => JUSTIFY_LEFT|FRAME_LINE)
    FXLabel.new(matrix, "AL", :opts => FRAME_LINE)
    FXLabel.new(matrix, "Homer Simpson", :opts => JUSTIFY_LEFT|FRAME_LINE|LAYOUT_FILL_X)
    FXLabel.new(matrix, "Springfield", :opts => JUSTIFY_LEFT|FRAME_LINE)
    FXLabel.new(matrix, "CT", :opts => FRAME_LINE)
    FXLabel.new(matrix, "Bob Smith", :opts => JUSTIFY_LEFT|FRAME_LINE|LAYOUT_FILL_X)
    FXLabel.new(matrix, "Walla Walla", :opts => JUSTIFY_LEFT|FRAME_LINE)
    FXLabel.new(matrix, "WA", :opts => FRAME_LINE)
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  FXApp.new do |app|
    MatrixExample.new(app)
    app.create
    app.run
  end
end
