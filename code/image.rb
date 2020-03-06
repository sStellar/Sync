#---
# Excerpted from "FXRuby: Create Lean and Mean GUIs with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fxruby for more book information.
#---
require 'fox16'

require 'open-uri'



include Fox

class ImagesWindow < FXMainWindow
  
  def initialize(app)
    super(app, "Image Demo", :width => 600, :height => 450)
    tab_book = FXTabBook.new(self, :opts => LAYOUT_FILL)
    FXTabItem.new(tab_book, "Bird's Nest")

    birdsnest_image =
      FXJPGImage.new(app, File.open("birdsnest.jpg", "rb").read)


    FXImageFrame.new(tab_book, birdsnest_image,
      :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_FILL)

    FXTabItem.new(tab_book, "Oscar")

oscar_image =
  FXJPGImage.new(app, open("http://tinyurl.com/35o8yy").read)

    tabbook_page = FXHorizontalFrame.new(tab_book, :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_FILL)

    FXImageView.new(tabbook_page, oscar_image, :opts => LAYOUT_FILL)

  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  FXApp.new do |app|
    ImagesWindow.new(app)
    app.create
    app.run
  end
end
