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

class CheckButtonsWindow < FXMainWindow
  
  def initialize(app)
    super(app, "Check Buttons", :width => 400, :height => 125, :padding => 10)


    @titles = FXDataTarget.new(true)
    @thumbnails = FXDataTarget.new(false)
    @mustaches = FXDataTarget.new(MAYBE)
    groupbox = FXGroupBox.new(self, "Options",
      :opts => GROUPBOX_NORMAL|FRAME_GROOVE|LAYOUT_FILL)
    titles_check = FXCheckButton.new(groupbox,
      "Display image titles",
      :target => @titles, :selector => FXDataTarget::ID_VALUE)
    thumbnails_check = FXCheckButton.new(groupbox,
      "Display images as thumbnails",
      :target => @thumbnails, :selector => FXDataTarget::ID_VALUE)
    mustaches_check = FXCheckButton.new(groupbox,
      "Draw mustaches on pictures of my enemies",
      :target => @mustaches, :selector => FXDataTarget::ID_VALUE)
    @titles.connect(SEL_COMMAND) do
      puts "The new value for 'titles' is #{@titles.value}"
    end

    @thumbnails.connect(SEL_COMMAND) do
      puts "The new value for 'thumbnails' is #{@thumbnails.value}"
    end
    @mustaches.connect(SEL_COMMAND) do
      puts "The new value for 'mustaches' is #{@mustaches.value}"
    end
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

end

if __FILE__ == $0
  
  FXApp.new do |app|
    CheckButtonsWindow.new(app)
    app.create
    app.run
  end
  
end
