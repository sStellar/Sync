require_relative "FileOb"
require_relative "src/print.rb"
require "fox16"
include Fox

class Gui < FXMainWindow

  def initialize(main_app, s_d = Dir.pwd)
    # Default dir
    if ARGV[0] == nil # Nothing there
      @spec_dir = s_d
    else # Something as ARGV[0]
      @spec_dir = ARGV[0]
    end

    # Data file dir
    if ARGV[1] == nil # Nothing there
      @data_dir = Dir.pwd + "/data/data.yaml"
    else # Something as ARGV[0]
      @data_dir = ARGV[1]
    end
    @fileob = FileOb.new(@spec_dir)
    p @spec_dir
    @fileob.read_yaml(@data_dir)

    running = true
    logic_t = Thread.new do
      while running
        @fileob.logic_func
        @fileob.save_yaml(@data_dir)
        sleep(2)
      end
    end
    # logic_t.join

    # ----------------------- APP START ------------------------------ #
    super(main_app, "File Sync", :width => 600, :height => 400)

    # --------------------------- FILES FRAME SETUP ---------------------------- #

    main_frame = FXVerticalFrame.new( self, :opts => LAYOUT_FILL )
    #h_frame = FXHorizontalFrame.new( v_frame, :padding => 0 )
    files_matrix = FXMatrix.new( main_frame, 3, MATRIX_BY_COLUMNS )
    FXLabel.new(files_matrix, "Files list: #{@spec_dir}")

    new_matrix = FXMatrix.new( main_frame, 3, MATRIX_BY_COLUMNS )
    FXLabel.new(new_matrix, "New Files:")


    main_table_frame = FXHorizontalFrame.new(main_frame, :padding => 0, :opts => LAYOUT_FILL)


    # ------------------------ FILES TABLE --------------------------- #

    file_list_frame = FXVerticalFrame.new(main_table_frame, :opts => FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL|LAYOUT_TOP, :padding => 0)
    files_table = FXTable.new(file_list_frame, :opts => LAYOUT_FILL, :padLeft => 7, :padRight => 10)
    files_table.tableStyle |= TABLE_COL_SIZABLE
    files_table.rowHeaderWidth = 5
    files_table.columnHeaderMode = LAYOUT_FIX_HEIGHT
    files_table.columnHeaderHeight = 10
    files_table.columnHeader


    # ------------------- NEW FILES TABLE ---------------------

    new_table = FXTable.new(new_list_frame, :opts => LAYOUT_FILL, :padLeft => 7, :padRight => 10)
    new_table.tableStyle |= TABLE_COL_SIZABLE
    new_table.rowHeaderWidth = 5
    new_table.columnHeaderMode = LAYOUT_FIX_HEIGHT
    new_table.columnHeaderHeight = 10
    new_table.columnHeader

    # ------------------- TABLES THREAD AND LOOP -----------------------

    tables_running = true
    tables_t = Thread.new do
      while tables_running
        # --------------- ALL FILES TABLE ---------------
        files_table.setTableSize(@fileob.file_inv.length+1, 2)
        files_table.setItemText(0, 0, "Files list:")
        files_table.setItemText(0, 1, "#{@fileob.file_inv.length} files")
        files_table.setItemJustify(0, 0, FXTableItem::CENTER_X|FXTableItem::CENTER_Y)
        files_table.setItemJustify(0, 1, FXTableItem::LEFT)

        v_i = 1 # Row text is displayed on, row 0 is "Files list"
        @fileob.file_inv.each do |file, mtime|
          file = file.include?(@spec_dir) ? file.sub(@spec_dir+"/","") : file # Remove directory from file names
          # If file has spec dir in it, file becomes file without spec dir. If it doesnt, just return file
          # Not sure when this would be useful but it could be, and it works and was fun so....
          files_table.setItemText(v_i, 0, file)
          files_table.setItemJustify(v_i, 0, FXTableItem::LEFT)
          files_table.setItemText(v_i, 1, mtime.to_s)

          v_i += 1
        end
        files_table.fitColumnsToContents(0)
        files_table.fitColumnsToContents(1)
        sleep(1)
      end
    end

    new_list_frame = FXVerticalFrame.new(main_table_frame, :opts => FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL|LAYOUT_TOP, :padding => 0)

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
    begin
      main_app.create
      main_app.run
    rescue IndexError => e
      retry
    end

  end
end
