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

class TextExample < FXMainWindow
  
  def initialize(app)
    super(app, "Finding Text", :width => 640, :height => 480)
    text = FXText.new(self, :opts => TEXT_WORDWRAP|LAYOUT_FILL)

    text.text =
      "Now is the time for all good men " +
      "to come to the aid of their country."
    first, last = text.findText("the")  # returns [7], [10]

    puts "first, last = #{first.inspect}, #{last.inspect}"

    first, last = text.findText("women")  # returns nil, nil

    puts "first, last = #{first.inspect}, #{last.inspect}"

    first, last = text.findText("the", :start => 20)  # returns [44], [47]

    puts "first, last = #{first.inspect}, #{last.inspect}"

    first, last = text.findText("ThE", :start => 20,
      :flags => SEARCH_BACKWARD|SEARCH_IGNORECASE)  # returns [7], [10]

    puts "first, last = #{first.inspect}, #{last.inspect}"

    first, last = text.findText("\\w{4}",
      :flags => SEARCH_REGEX)  # returns [11], [15]

    puts "first, last = #{first.inspect}, #{last.inspect}"

    first, last = text.findText("the (\\w+ (\\w+)) (\\w+)",
      :flags => SEARCH_REGEX)  # returns [7, 11, 16, 20], [23, 19, 19, 23]

    puts "first, last = #{first.inspect}, #{last.inspect}"
    group1, group2, group3 = nil, nil, nil

    if text.text =~ /the (\w+ (\w+)) (\w+)/
      group0, group1, group2, group3 = $~[0], $~[1], $~[2], $~[3]
    end

    puts "group0, group1, group2, group3 = #{group0}, #{group1}, #{group2}, #{group3}"
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  
  FXApp.new do |app|
    TextExample.new(app)
    app.create
    app.run
  end
  
end
