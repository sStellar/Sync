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
    super(app, "Table Example", :width => 600, :height => 300)

    table = FXTable.new(self, :opts => LAYOUT_FILL)
    table.setTableSize(6, 4)

    stopwatch_icon = nil
    File.open("stopwatch.gif", "rb") do |io|
      stopwatch_icon = FXGIFIcon.new(app, io.read)
    end
    error_icon = nil
    File.open("error.png", "rb") do |io|
      error_icon = FXPNGIcon.new(app, io.read)
    end

    table.setColumnText(0, "Ruby 1.8.6")
    table.setColumnText(1, "Ruby 1.9")
    table.setColumnText(2, "JRuby")
    table.setColumnText(3, "Rubinius")

    table.rowHeaderMode = ~LAYOUT_FIX_WIDTH
    table.columnHeader.setItemJustify(0, FXHeaderItem::CENTER_X)
    table.columnHeader.setItemJustify(1, FXHeaderItem::CENTER_X)
    table.columnHeader.setItemJustify(2, FXHeaderItem::CENTER_X)
    table.columnHeader.setItemJustify(3, FXHeaderItem::CENTER_X)
    table.setRowText(0, "app_answer")
    table.setRowText(1, "app_factorial")
    table.setRowText(2, "app_easier_fact")
    table.setRowText(3, "app_fib")
    table.setRowText(4, "app_mandelbrot")
    table.setRowText(5, "app_pentomino")
    table.setItemText(0, 0, "1.00")
    table.setItemText(0, 1, "5.46")
    table.setItemText(0, 2, "1.79")
    table.setItemText(0, 3, "2.85")
    table.setItemText(1, 0, "Error")
    table.setItemText(1, 1, "1.28")
    table.setItemText(1, 2, "0.48")
    table.setItemText(1, 3, "Error")
    table.setItemText(2, 0, "1.00")
    table.setItemText(2, 1, "0.87")
    table.setItemText(2, 2, "0.28")
    table.setItemText(2, 3, "0.48")
    table.setItemText(3, 0, "1.00")
    table.setItemText(3, 1, "4.70")
    table.setItemText(3, 2, "2.55")
    table.setItemText(3, 3, "1.55")
    table.setItemText(4, 0, "1.00")
    table.setItemText(4, 1, "2.63")
    table.setItemText(4, 2, "0.55")
    table.setItemText(4, 3, "Error")
    table.setItemText(5, 0, "1.00")
    table.setItemText(5, 1, "2.21")
    table.setItemText(5, 2, "0.81")

    table.setItemText(5, 3, "Timeout")
    table.setItemIcon(5, 3, stopwatch_icon)
    table.setItemJustify(5, 3, FXTableItem::CENTER_X)
    table.setItemIconPosition(5, 3, FXTableItem::BEFORE)

    table.setItemIcon(1, 0, error_icon)
    table.setItemJustify(1, 0, FXTableItem::CENTER_X)
    table.setItemIconPosition(1, 0, FXTableItem::BEFORE)
    table.setItemIcon(1, 3, error_icon)
    table.setItemJustify(1, 3, FXTableItem::CENTER_X)
    table.setItemIconPosition(1, 3, FXTableItem::BEFORE)
    table.setItemIcon(4, 3, error_icon)
    table.setItemJustify(4, 3, FXTableItem::CENTER_X)
    table.setItemIconPosition(4, 3, FXTableItem::BEFORE)

    selected_items = []
    table.connect(SEL_SELECTED) do |sender, sel, pos|
      item = sender.getItem(pos.row, pos.col)
      selected_items << item unless selected_items.include? item
    end
    table.connect(SEL_DESELECTED) do |sender, sel, pos|
      selected_items.delete(sender.getItem(pos.row, pos.col))
    end

    table.connect(SEL_COMMAND) do |sender, sel, data|
      puts "anchor row, col = #{sender.anchorRow}, #{sender.anchorColumn}"
    end
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
