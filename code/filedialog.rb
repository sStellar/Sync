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

class FileDialogExample < FXMainWindow
  def initialize(app)
    super(app, "File Dialog Example", :width => 300, :height => 100)
    open_existing_btn = FXButton.new(self, "Open Existing File...", :opts => BUTTON_NORMAL|LAYOUT_CENTER_X)
    open_existing_btn.connect(SEL_COMMAND) do

      dialog = FXFileDialog.new(self, "Open JPEG File")
      dialog.patternList = [
        "All Files (*)",
        "JPEG Files (*.jpg, *.jpeg)"
      ]
      dialog.selectMode = SELECTFILE_EXISTING
      if dialog.execute != 0
        open_jpeg_file(dialog.filename)
      end

    end
    open_multiple_btn = FXButton.new(self, "Open Multiple Files...", :opts => BUTTON_NORMAL|LAYOUT_CENTER_X)
    open_multiple_btn.connect(SEL_COMMAND) do

      dialog = FXFileDialog.new(self, "Open JPEG File(s)")
      dialog.patternList = [
        "All Files (*)",
        "JPEG Files (*.jpg, *.jpeg)"
      ]
      dialog.selectMode = SELECTFILE_MULTIPLE
      if dialog.execute != 0
        dialog.filenames.each do |filename|
          open_jpeg_file(filename)
        end
      end

    end
  end
  
  def open_jpeg_file(filename)
    puts "open_jpeg_file(#{filename})"
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    FileDialogExample.new(app)
    app.create
    app.run
  end
end