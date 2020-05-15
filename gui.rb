require_relative "src/FileOb"
require_relative "src/print.rb"
require "fox16"
include Fox

class Gui < FXMainWindow

  def initialize(main_app)
    # -------------------------- MAIN LOGIC PART ------------------------
    # Default dir path
    @spec_dir = ARGV[0] == nil ? Dir.pwd : ARGV[0]
    # => If theres nothing in cmd use working dir, if there is use ARGV

    # Data file path
    @data_dir = ARGV[1] == nil ? Dir.pwd + "/data/data.yaml" : ARGV[1]
    # => If theres nothing in cmd use default path, if there is use ARGV
    puts "Paths"
    p @spec_dir
    p @data_dir
    @fileob = FileOb.new(@spec_dir)
    @fileob.read_yaml(@data_dir)

    running = true
    logic_t = Thread.new do
      while running
        @fileob.logic_func
        @fileob.save_yaml(@data_dir)
        sleep(2)
      end
    end

    puts "New files:"
    p @fileob.new_files
    puts "Edited files:"
    p @fileob.edited_files
    # ----------------------- APP START ------------------------------ #
    super(main_app, "File Sync", :width => 600, :height => 400)

    # --------------------------- FILES FRAME SETUP ---------------------------- #

    main_frame = FXVerticalFrame.new( self, :opts => LAYOUT_FILL )
    files_matrix = FXMatrix.new( main_frame, 1, MATRIX_BY_COLUMNS )
    FXLabel.new(files_matrix, "Files list: #{@spec_dir}")

    new_matrix = FXMatrix.new( main_frame, 1, MATRIX_BY_COLUMNS )
    FXLabel.new(new_matrix, "New Files: #{@fileob.new_files.length}")

    edited_matrix = FXMatrix.new( main_frame, 1, MATRIX_BY_COLUMNS )
    FXLabel.new(edited_matrix, "Edited Files: #{@fileob.edited_files.length}")

    deleted_matrix = FXMatrix.new( main_frame, 1, MATRIX_BY_COLUMNS )
    FXLabel.new(deleted_matrix, "Edited Files: #{@fileob.del_files.length}")

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
    new_list_frame = FXVerticalFrame.new(main_table_frame, :opts => FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL|LAYOUT_TOP, :padding => 0)
    new_table = FXTable.new(new_list_frame, :opts => LAYOUT_FILL, :padLeft => 7, :padRight => 10)
    new_table.tableStyle |= TABLE_COL_SIZABLE
    new_table.rowHeaderWidth = 5
    new_table.columnHeaderMode = LAYOUT_FIX_HEIGHT
    new_table.columnHeaderHeight = 10
    new_table.columnHeader

    # ------------------- EDITED FILES TABLE ---------------------

    edited_table = FXTable.new(main_table_frame, :opts => LAYOUT_FILL, :padLeft => 7, :padRight => 10)
    edited_table.tableStyle |= TABLE_COL_SIZABLE
    edited_table.rowHeaderWidth = 5
    edited_table.columnHeaderMode = LAYOUT_FIX_HEIGHT
    edited_table.columnHeaderHeight = 10
    edited_table.columnHeader

    # ------------------- Deleted FILES TABLE ---------------------

    deleted_table = FXTable.new(main_table_frame, :opts => LAYOUT_FILL, :padLeft => 7, :padRight => 10)
    deleted_table.tableStyle |= TABLE_COL_SIZABLE
    deleted_table.rowHeaderWidth = 5
    deleted_table.columnHeaderMode = LAYOUT_FIX_HEIGHT
    deleted_table.columnHeaderHeight = 10
    deleted_table.columnHeader

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
          file = file.include?(@spec_dir) ? file.sub(@spec_dir+"/","") : file
          # Remove spec dir from file name to reduce length and make the table nicer
          files_table.setItemText(v_i, 0, file)
          files_table.setItemJustify(v_i, 0, FXTableItem::LEFT)
          files_table.setItemText(v_i, 1, mtime.to_s)

          v_i += 1
        end
        files_table.fitColumnsToContents(0)
        files_table.fitColumnsToContents(1)

        # --------------- NEW FILES TABLE ---------------

        new_table.setTableSize(@fileob.new_files.length+1, 1)
        new_table.setItemText(0, 0, "New Files list:")
        new_table.setItemJustify(0, 0, FXTableItem::CENTER_X|FXTableItem::CENTER_Y)

        v_i = 1 # Row text is displayed on, row 0 is "New Files"
        @fileob.new_files.each do |new|
          new = new.include?(@spec_dir) ? new.sub(@spec_dir+"/","") : new
          # Remove spec dir from file name to reduce length and make the table nicer
          new_table.setItemText(v_i, 0, new)
          new_table.setItemJustify(v_i, 0, FXTableItem::LEFT)

          v_i += 1
        end
        new_table.fitColumnsToContents(0)

        # --------------- EDITED FILES TABLE ---------------

        edited_table.setTableSize(@fileob.edited_files.length+1, 1)
        edited_table.setItemText(0, 0, "Edited files:")
        edited_table.setItemJustify(0, 0, FXTableItem::CENTER_X|FXTableItem::CENTER_Y)

        v_i = 1 # Row text is displayed on, row 0 is "Edied files"
        @fileob.edited_files.each do |file|
          file = file.include?(@spec_dir) ? file.sub(@spec_dir+"/","") : file
          # Remove spec dir from file name to reduce length and make the table nicer
          edited_table.setItemText(v_i, 0, file)
          edited_table.setItemJustify(v_i, 0, FXTableItem::LEFT)

          v_i += 1
        end
        edited_table.fitColumnsToContents(0)

        # --------------- DELETED FILES TABLE ---------------

        deleted_table.setTableSize(@fileob.del_files.length+1, 1)
        deleted_table.setItemText(0, 0, "Deleted files:")
        deleted_table.setItemJustify(0, 0, FXTableItem::CENTER_X|FXTableItem::CENTER_Y)

        v_i = 1 # Row text is displayed on, row 0 is "Edied files"
        @fileob.del_files.each do |file|
          file = file.include?(@spec_dir) ? file.sub(@spec_dir+"/","") : file
          # Remove spec dir from file name to reduce length and make the table nicer
          deleted_table.setItemText(v_i, 0, file)
          deleted_table.setItemJustify(v_i, 0, FXTableItem::LEFT)

          v_i += 1
        end
        deleted_table.fitColumnsToContents(0)

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
    gui = Gui.new(main_app)
    begin
      main_app.create
      main_app.run
    rescue IndexError => e
      retry
    end

  end
end
