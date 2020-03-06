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

$state_names  = %w{Alabama Alaska Arizona Arkansas California Colorado Connecticut Delaware Florida Georgia Hawaii}
$state_names += %w{Idaho Illinois Indiana Iowa Kansas Kentucky Louisiana Maine Maryland Massachusetts Michigan}
$state_names += %w{Minnesota Mississippi Missouri Montana Nebraska Nevada New\ Hampshire New\ Jersey New\ York}
$state_names += %w{North\ Carolina North\ Dakota Ohio Oklahoma Oregon Pennsylvania Rhode\ Island South\ Carolina}
$state_names += %w{Tennessee Texas Utah Vermont Washington West\ Virginia Wisconsin Wyoming}

class MenuExample < FXMainWindow
  def initialize(app)
    super(app, "Menus Example", :width => 400, :height => 200)
    menu_bar = FXMenuBar.new(self, :opts => LAYOUT_SIDE_TOP|LAYOUT_FILL_X)

    file_menu_pane = FXMenuPane.new(self)
    file_new_command = FXMenuCommand.new(file_menu_pane, "New")
    file_open_command = FXMenuCommand.new(file_menu_pane, "Open...")
    file_save_command = FXMenuCommand.new(file_menu_pane, "Save")
    file_save_as_command = FXMenuCommand.new(file_menu_pane, "Save As...")
    file_menu_title = FXMenuTitle.new(menu_bar, "File",
      :popupMenu => file_menu_pane)


    export_menu_pane = FXMenuPane.new(self)
    export_gif_command =
      FXMenuCommand.new(export_menu_pane, "Export as GIF")
    export_jpeg_command =
      FXMenuCommand.new(export_menu_pane, "Export as JPEG")
    export_png_command =
      FXMenuCommand.new(export_menu_pane, "Export as PNG")
    export_tiff_command =
      FXMenuCommand.new(export_menu_pane, "Export as TIFF")


		export_cascade = FXMenuCascade.new(file_menu_pane, "Export",
		  :popupMenu => export_menu_pane)


    states_menu_pane = FXScrollPane.new(self, 8)
    $state_names.each do |state_name|
      FXMenuCommand.new(states_menu_pane, state_name)
    end
    states_menu_title = FXMenuTitle.new(menu_bar, "States",
      :popupMenu => states_menu_pane)


    @size = FXDataTarget.new(1)
    size_pane = FXMenuPane.new(self)
    FXMenuRadio.new(size_pane, "Small",
      :target => @size, :selector => FXDataTarget::ID_OPTION)
    FXMenuRadio.new(size_pane, "Medium",
      :target => @size, :selector => FXDataTarget::ID_OPTION+1)
    FXMenuRadio.new(size_pane, "Large",
      :target => @size, :selector => FXDataTarget::ID_OPTION+2)
    FXMenuRadio.new(size_pane, "Jumbo",
      :target => @size, :selector => FXDataTarget::ID_OPTION+3)
    size_menu_title = FXMenuTitle.new(menu_bar, "Size",
      :popupMenu => size_pane)
    @size.connect(SEL_COMMAND) do
      # @size.value holds the index of the selected size
    end

    FXMenuSeparator.new(size_pane)

    @fit_to_screen = FXDataTarget.new(false)
    FXMenuCheck.new(size_pane, "Fit Contents to Screen",
      :target => @fit_to_screen, :selector => FXDataTarget::ID_VALUE)


    tool_bar_shell = FXToolBarShell.new(self)


    top_dock_site = FXDockSite.new(self,
      :opts => LAYOUT_FILL_X|LAYOUT_SIDE_TOP)
    bottom_dock_site = FXDockSite.new(self,
      :opts => LAYOUT_FILL_X|LAYOUT_SIDE_BOTTOM)


    tool_bar = FXToolBar.new(top_dock_site, tool_bar_shell,
      :opts => PACK_UNIFORM_WIDTH|FRAME_RAISED|LAYOUT_FILL_X)


    FXToolBarGrip.new(tool_bar,
      :target => tool_bar, :selector => FXToolBar::ID_TOOLBARGRIP,
      :opts => TOOLBARGRIP_DOUBLE)

    new_icon = load_icon("filenew.png")
    open_icon= load_icon("fileopen.png")
    save_icon = load_icon("filesave.png")
    save_as_icon = load_icon("filesaveas.png")

    new_button = FXButton.new(tool_bar,
      "\tNew\tCreate new document.",
      :icon => new_icon)
    open_button = FXButton.new(tool_bar,
      "\tOpen\tOpen document file.",
      :icon => open_icon)
    save_button = FXButton.new(tool_bar,
      "\tSave\tSave document.",
      :icon => save_icon)
    save_as_button = FXButton.new(tool_bar,
      "\tSave As\tSave document to another file.",
      :icon => save_as_icon)

  end
  
  def load_icon(filename)
    icon = nil
    File.open(filename, "rb") do |io|
      icon = FXPNGIcon.new(app, io.read)
    end
    icon
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    MenuExample.new(app)
    app.create
    app.run
  end
end