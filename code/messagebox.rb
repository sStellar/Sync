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

class MessageBoxExample < FXMainWindow
  def initialize(app)
    super(app, "Message Box Example", :width => 300, :height => 100)
    warning_btn = FXButton.new(self, "Warning...", :opts => BUTTON_NORMAL|LAYOUT_CENTER_X)
    warning_btn.connect(SEL_COMMAND) do

      FXMessageBox.warning(
        self,
        MBOX_OK,
        "Buyer Beware",
        "All Sales are Final!"
      )

    end
    question_btn = FXButton.new(self, "Question...", :opts => BUTTON_NORMAL|LAYOUT_CENTER_X)
    question_btn.connect(SEL_COMMAND) do

      answer = FXMessageBox.question(
        self,
        MBOX_YES_NO,
        "Just one question...",
        "Is it safe?"
      )
      if answer == MBOX_CLICKED_YES
        ask_again()
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
    MessageBoxExample.new(app)
    app.create
    app.run
  end
end