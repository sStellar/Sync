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

class ListExample < FXMainWindow
  def initialize(app)
    super(app, "Grocery List", :width => 400, :height => 200)
    summary = FXTextField.new(self, 20, :opts => TEXTFIELD_NORMAL|LAYOUT_SIDE_BOTTOM|LAYOUT_FILL_X)
    FXHorizontalSeparator.new(self, LAYOUT_FILL_X|SEPARATOR_GROOVE|LAYOUT_SIDE_BOTTOM)

    groceries = FXList.new(self,
      :opts => LIST_EXTENDEDSELECT|LAYOUT_FILL)
    groceries.appendItem("Milk")
    groceries.appendItem("Eggs")
    groceries.appendItem("Bacon (Chunky)")


    groceries.prependItem("Bread")
    groceries.insertItem(2, "Peanut Butter")
    groceries.removeItem(3)

    groceries.connect(SEL_COMMAND) do

      selected_items = []
      groceries.each { |item| selected_items << item if item.selected? }

      unless selected_items.empty?
        summary_text = ""
        selected_items.each do |item|
          summary_text += ", " unless summary_text.empty?
          summary_text += item.text
        end
        summary.text = summary_text
      else
        puts "No items selected"
      end
    end
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    ListExample.new(app)
    app.create
    app.run
  end
end
