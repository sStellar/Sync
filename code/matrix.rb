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
    super(app, "Matrix Layout Example", :width => 400, :height => 200)

    matrix = FXMatrix.new(self, 3, :opts => MATRIX_BY_ROWS|LAYOUT_FILL)

    1.upto(12) do |i|
      FXLabel.new(matrix, "#{i}")
    end
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
