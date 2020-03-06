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

class LabelExample < FXMainWindow
  def initialize(app)
    super(app, "Labels", :width => 300, :height => 100)

    question_icon =
      FXGIFIcon.new(app, File.open("question.gif", "rb").read)
    question_label =
      FXLabel.new(self, "Is it safe?", :icon => question_icon)


    question_label.iconPosition = ICON_BEFORE_TEXT

    question_label.layoutHints = LAYOUT_CENTER_X|LAYOUT_CENTER_Y
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    LabelExample.new(app)
    app.create
    app.run
  end
end
