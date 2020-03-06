#---
# Excerpted from "FXRuby: Create Lean and Mean GUIs with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fxruby for more book information.
#---

require 'photo_view'


class AlbumView < FXScrollWindow


  attr_reader :album



  def initialize(p, album)
    super(p, :opts => LAYOUT_FILL)

    @album = album
    FXMatrix.new(self, :opts => LAYOUT_FILL|MATRIX_BY_COLUMNS)
    @album.each_photo { |photo| add_photo(photo) }



    # ...


  end


  

  def layout
    contentWindow.numColumns = [width/PhotoView::MAX_WIDTH, 1].max
    super
  end



  def add_photo(photo)
    PhotoView.new(contentWindow, photo)
  end



  # ...

end


