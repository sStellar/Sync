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

class TableExample < FXMainWindow
  def initialize(app)
    super(app, "Table Example", :width => 600, :height => 200)

    table = FXTable.new(self, :opts => LAYOUT_FILL)
    table.setTableSize(10, 10)


    table.rowHeaderMode = LAYOUT_FIX_WIDTH
    table.rowHeaderWidth = 0
    table.columnHeaderMode = LAYOUT_FIX_HEIGHT
    table.columnHeaderHeight = 0

    table.setItemText(0, 0, "An item")
    table.setItemText(4, 4, "Another item")

    table.setItemText(2, 1, "This is a spanning item")
    table.setItemJustify(2, 1, FXTableItem::CENTER_X)
    spanning_item = table.getItem(2, 1)
    table.setItem(2, 2, spanning_item)
    table.setItem(2, 3, spanning_item)
    table.setItem(3, 1, spanning_item)
    table.setItem(3, 2, spanning_item)
    table.setItem(3, 3, spanning_item)

  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    TableExample.new(app)
    app.create
    app.run
  end
end
