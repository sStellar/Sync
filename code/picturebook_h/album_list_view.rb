#---
# Excerpted from "FXRuby: Create Lean and Mean GUIs with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fxruby for more book information.
#---
class AlbumListView < FXList  

  attr_reader :album_list

  def initialize(p, opts, album_list)
    super(p, :opts => opts)
    @album_list = album_list
    @album_list.each_album do |album|
      add_album(album)
    end
  end
  
  def add_album(album)
    appendItem(album.title)
  end
end
