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
require 'album_list'
require 'album_list_view'
require 'album_view'
require 'photo'

class PictureBook < FXMainWindow

  def initialize(app)
    super(app, "Picture Book", :width => 600, :height => 400)
    add_menu_bar
    @album = Album.new("My Photos")
    @album_list = AlbumList.new
    @album_list.add_album(@album)
    splitter = FXSplitter.new(self,
      :opts => SPLITTER_HORIZONTAL|LAYOUT_FILL)
    @album_list_view = AlbumListView.new(splitter,
      LAYOUT_FILL, @album_list)

    @switcher = FXSwitcher.new(splitter, :opts => LAYOUT_FILL)


    @switcher.connect(SEL_UPDATE) do
      @switcher.current = @album_list_view.currentItem
    end


    AlbumView.new(@switcher, @album)

  end


  def add_menu_bar
    menu_bar = FXMenuBar.new(self, LAYOUT_SIDE_TOP|LAYOUT_FILL_X)
    file_menu = FXMenuPane.new(self)
    FXMenuTitle.new(menu_bar, "File", :popupMenu => file_menu)
    import_cmd = FXMenuCommand.new(file_menu, "Import...")
    import_cmd.connect(SEL_COMMAND) do
      dialog = FXFileDialog.new(self, "Import Photos")
      dialog.selectMode = SELECTFILE_MULTIPLE
      dialog.patternList = ["JPEG Images (*.jpg, *.jpeg)"]
      if dialog.execute != 0
        import_photos(dialog.filenames)
      end
    end



    new_album_command = FXMenuCommand.new(file_menu, "New Album...")
    new_album_command.connect(SEL_COMMAND) do

      # ...



      album_title =
        FXInputDialog.getString("My Album", self, "New Album", "Name:")


      if album_title
        album = Album.new(album_title)
        @album_list.add_album(album)
        @album_list_view.add_album(album)
        AlbumView.new(@switcher, album)
      end


    end



    exit_cmd = FXMenuCommand.new(file_menu, "Exit")
    exit_cmd.connect(SEL_COMMAND) do
      exit
    end
  end
  

  def current_album
    current_album_view.album
  end



  def current_album_view
    @switcher.childAtIndex(@switcher.current)
  end



  def import_photos(filenames)
    filenames.each do |filename|
      photo = Photo.new(filename)
      current_album.add_photo(photo)
      current_album_view.add_photo(photo)
    end
    current_album_view.create
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
