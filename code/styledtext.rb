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

class StyledTextExample < FXMainWindow
  
  def initialize(app)
    super(app, "Styled Text Example", :width => 400, :height => 100)
    text = FXText.new(self, :opts => TEXT_WORDWRAP|LAYOUT_FILL)
    text.text = "This line of text contains some information that I merely want to call out, using a yellow background, "
    text.text += "while this line contains something extremely important, so I'll use a bold font and red letters to get your attention"
    

    text.styled = true




    style1 = FXHiliteStyle.from_text(text)

    style1.normalBackColor = "yellow"
    
    style2 = FXHiliteStyle.from_text(text)
    style2.normalForeColor = "red"
    style2.style = FXText::STYLE_BOLD



    text.hiliteStyles = [style1, style2]

    

    first, last = text.findText("yellow background")
    start_pos = first[0]
    length = last[0] - first[0]
    text.changeStyle(start_pos, length, 1)


    first, last = text.findText("bold font and red letters")
    start_pos = first[0]
    length = last[0] - first[0]
    text.changeStyle(start_pos, length, 2)
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  
  FXApp.new do |app|
    StyledTextExample.new(app)
    app.create
    app.run
  end
  
end
