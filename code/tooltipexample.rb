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

class ToolTipExample < FXMainWindow
  def initialize(app)
    super(app, "ToolTip and Status Bar Example", :width => 400, :height => 100)
    FXStatusBar.new(self, :opts => LAYOUT_SIDE_BOTTOM|LAYOUT_FILL_X)

    FXToolTip.new(app)


    upload_button = FXButton.new(self, "Upload\tUpload Files")


    download_button = FXButton.new(self,
      "Download\tDownload Files\tStart Downloading Files in the Background")


    dial = FXDial.new(self, :opts => DIAL_HORIZONTAL)
    dial.range = 0..11
    dial.tipText = "Volume"


    dial.helpText = "This one goes to eleven"

  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    ToolTipExample.new(app)
    app.create
    app.run
  end
end