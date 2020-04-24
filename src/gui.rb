require_relative "FileObserver"
require_relative "print"
require "fox16"
include Fox

class Gui < FXMainWindow

  def initialize(main_app, s_d = "../**/*")
    @spec_dir = s_d
    @fileob = FileObserver.new(@spec_dir)
    p Dir.pwd
    @fileob.readData("/home/peter/Sync/data/data.yaml")

    # ----------------------- TEXT START ------------------------------ #
    super(main_app, "File Sync", :width => 200, :height => 100)

    # --------------------------- FRAME SETUP ---------------------------- #

    v_frame = FXVerticalFrame.new( self, :opts => LAYOUT_FILL )
    h_frame = FXHorizontalFrame.new( v_frame, :padding => 0 )
    matrix = FXMatrix.new( h_frame, 3, MATRIX_BY_COLUMNS|LAYOUT_FILL )

    # ------------------------ FILES TABLE --------------------------- #

    FXLabel.new(matrix, "Treelist:")
    @fileob.thread( @fileob.all_files )

    @treelist = FXTreeList.new(v_frame,:opts => TREELIST_NORMAL|TREELIST_SHOWS_LINES|TREELIST_SHOWS_BOXES|TREELIST_ROOT_BOXES|LAYOUT_FILL)


    
=begin
    listview_frame = FXHorizontalFrame.new(v_frame, :opts => FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL|LAYOUT_TOP, :padding => 0)
    @table = FXTable.new(listview_frame, :opts => LAYOUT_FILL)
    @table.tableStyle |= TABLE_COL_SIZABLE

    @table.rowHeaderWidth = 0
    @table.columnHeaderMode = LAYOUT_FIX_HEIGHT
    @table.columnHeaderHeight = 0
    @table.columnHeader

    filefuck = { "Jane Doe" => 10, "Jim Do" => 6, "Jim oe" => 6, "Jim De" => 6, "Ji Doe" => 6 }
    a = 1
    b = 0
    wd = Dir.pwd
    dir = Dir.glob('**/*', base:wd)
    c = dir.length

    @table.setTableSize(c + 1, 4)
    @table.setItemText(0,0, "Contents of Keylocker folder")
    @table.setItemJustify(0,0, FXTableItem::CENTER_X|FXTableItem::CENTER_Y)

    dir.each do |dir|
        temp = File.mtime(dir)
        @table.setItemText(a, b, "#{wd}/#{dir}")
        @table.setItemJustify(a, 0, FXTableItem::LEFT)
        @table.setItemText(a, 3, "#{temp}")
        a += 1
    end
=end

  end


  # Create App
  def create()
    super
    show(PLACEMENT_SCREEN)
  end
end


if __FILE__ == $0
  FXApp.new do |main_app|
    gui = Gui.new(main_app)

    main_app.create
    main_app.run
  end
end
