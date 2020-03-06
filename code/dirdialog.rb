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

class DirDialogExample < FXMainWindow
  def initialize(app)
    super(app, "Directory Dialog Example", :width => 300, :height => 100)
    open_dir_btn = FXButton.new(self, "Choose Directory...", :opts => BUTTON_NORMAL|LAYOUT_CENTER_X)
    open_dir_btn.connect(SEL_COMMAND) do

      dialog = FXDirDialog.new(self, "Choose Directory")
      dialog.directory = "/Users/lyle"
      if dialog.execute != 0
        open_directory(dialog.directory)
      end

    end
  end
  
  def open_directory(dir)
    puts "open_directory(#{dir})"
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    DirDialogExample.new(app)
    app.create
    app.run
  end
end
