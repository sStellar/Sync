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

class SplitterExample < FXMainWindow
  def initialize(app)
    super(app, "Splitter Example", :width => 400, :height => 400)
    @splitter = FXSplitter.new(self, :opts => LAYOUT_FILL)
    FXLabel.new(@splitter, "Left", :opts => LAYOUT_FILL|FRAME_SUNKEN|FRAME_THICK)
    FXLabel.new(@splitter, "Right", :opts => LAYOUT_FILL|FRAME_SUNKEN|FRAME_THICK)
    self.connect(SEL_CLOSE) do

      app.reg.writeIntEntry("Settings", "splitSize", @splitter.getSplit(0))
      app.exit(0)

    end
  end
  

  def create
    super
    @splitter.setSplit(0, app.reg.readIntEntry("Settings", "splitSize"))
    show(PLACEMENT_SCREEN)
  end

end

if __FILE__ == $0
  FXApp.new do |app|
    SplitterExample.new(app)
    app.create
    app.run
  end
end