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

class FontsWindow < FXMainWindow
  
  def initialize(app)
    super(app, "Fonts Demo", :width => 400, :height => 200)

    label1 =
      FXLabel.new(self, "This label uses a 14 point Arial italic font.")
    label1.font = FXFont.new(app, "Arial", 14, :slant => FXFont::Italic)


    label2 =
      FXLabel.new(self, "This label uses a 12 point Times bold font.")
    label2.font = FXFont.new(app, "Times,120,bold")


    label3 = FXLabel.new(self, "This label should use a fixed-width font.")
    fonts = FXFont.listFonts("", :slant => FXFont::Straight,
      :hints => FXFont::Fixed)
    label3.font = FXFont.new(app, fonts.first)


    label4 = FXLabel.new(self,
      "This label should use a very small fixed-width font!")
    fonts = FXFont.listFonts("", :slant => FXFont::Straight,
      :hints => FXFont::Fixed)
    sorted_by_size = fonts.sort { |a, b| a.size <=> b.size }
    label4.font = FXFont.new(app, sorted_by_size.find { |f| f.size > 20 })

  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  FXApp.new do |app|
    FontsWindow.new(app)
    app.create
    app.run
  end
end
