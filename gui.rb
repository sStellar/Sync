require_relative "FileOb"
require_relative "src/print.rb"
require "fox16"
include Fox

class Gui < FXMainWindow

  def initialize(main_app, s_d = "../**/*")
    @spec_dir = s_d
    @fileob = FileOb.new(@spec_dir)
    p Dir.pwd
    @fileob.read_yaml("/home/peter/Sync/data/data.yaml")

    running = true
    logic_t = Thread.new do
      while running
        @fileob.logic_func
        @fileob.save_yaml
        sleep(2)
      end
    end
    # logic_t.join

    # ----------------------- TEXT START ------------------------------ #
    super(main_app, "File Sync", :width => 200, :height => 100)

    # --------------------------- FILES FRAME SETUP ---------------------------- #

    v_frame = FXVerticalFrame.new( self, :opts => LAYOUT_FILL )
    h_frame = FXHorizontalFrame.new( v_frame, :padding => 0 )
    matrix = FXMatrix.new( h_frame, 3, MATRIX_BY_COLUMNS|LAYOUT_FILL )

    # ------------------------ FILES TABLE --------------------------- #

    FXLabel.new(matrix, "Files list:")

    file_list_frame = FXHorizontalFrame.new(v_frame, :opts => FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL|LAYOUT_TOP, :padding => 0)
    @table = FXTable.new(file_list_frame, :opts => LAYOUT_FILL, :padLeft => 7, :padRight => 10)
    @table.tableStyle |= TABLE_COL_SIZABLE
    @table.rowHeaderWidth = 5
    @table.columnHeaderMode = LAYOUT_FIX_HEIGHT
    @table.columnHeaderHeight = 10
    @table.columnHeader

    # ------- Add file inv text to table --------

    files_running = true
    files_t = Thread.new do
      while files_running
        @table.setTableSize(@fileob.file_inv.length+1, 2)
        @table.setItemText(0, 0, "Files list:")
        @table.setItemText(0, 1, "#{@fileob.file_inv.length} files")
        @table.setItemJustify(0, 0, FXTableItem::CENTER_X|FXTableItem::CENTER_Y)
        @table.setItemJustify(0, 1, FXTableItem::LEFT)

        v_i = 1 # Row text is displayed on, row 0 is "Files list"
        @fileob.file_inv.each do |file, mtime|
          file = file.include?(@spec_dir) ? file.sub(@spec_dir+"/","") : file # Remove directory from file names
          @table.setItemText(v_i, 0, file)
          @table.setItemJustify(v_i, 0, FXTableItem::LEFT)
          @table.setItemText(v_i, 1, mtime.to_s)

          v_i += 1
        end
        @table.fitColumnsToContents(0)
        @table.fitColumnsToContents(1)
        sleep(2)
      end
    end

  end

  # Create App
  def create()
    super
    show(PLACEMENT_SCREEN)
  end
end


if __FILE__ == $0
  FXApp.new do |main_app|
    gui = Gui.new(main_app, "/home/peter/Sync")

    running = true
    main_app.create
    main_app.run
  end
end
