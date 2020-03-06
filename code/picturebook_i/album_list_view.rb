#---
# Excerpted from "FXRuby: Create Lean and Mean GUIs with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fxruby for more book information.
#---
class AlbumListView < FXList
  
  attr_accessor :album_list


  def initialize(p, opts)
    super(p, :opts => opts)
  end



  def album_list=(albums)
    @album_list = albums
    @album_list.each_album do |album|
      add_album(album)
    end
  end



  def switcher=(sw)
    @switcher = sw
  end

 

  def add_album(album)
    appendItem(album.title)
    AlbumView.new(@switcher, album)
  end

end
