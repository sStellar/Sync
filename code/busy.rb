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

class WaitCursorExample < FXMainWindow
  
  def initialize(app)
    super(app, "Wait Cursor Example", :width => 300, :height => 300)

    open_button = FXButton.new(self, "Open File")
    open_button.connect(SEL_COMMAND) do
      app.beginWaitCursor do
        open_file # this may take awhile...
      end
    end

  end
  
  def open_file
    sleep(5)
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  FXApp.new do |app|
    WaitCursorExample.new(app)
    app.create
    app.run
  end
end
