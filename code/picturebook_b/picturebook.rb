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

require 'album'
require 'album_view'
require 'photo'

class PictureBook < FXMainWindow

  def initialize(app)
    super(app, "Picture Book", :width => 600, :height => 400)
    @album = Album.new("My Photos")
    @album.add_photo(Photo.new("shoe.jpg"))
    @album.add_photo(Photo.new("oscar.jpg"))
    @album_view = AlbumView.new(self, @album)
  end


  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    PictureBook.new(app)
    app.create
    app.run
  end
end
