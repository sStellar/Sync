require 'fox16'

include Fox

class ComboBoxExample < FXMainWindow
    
    def initialize(app)
        super(app, "Google Classroom Assignment Downloader", :width => 800, :height => 400)
        
        v_frame = FXVerticalFrame.new( self, :opts => LAYOUT_FILL )
        h_frame = FXHorizontalFrame.new(v_frame, :padding => 0 )
        matrix = FXMatrix.new( h_frame, 3, MATRIX_BY_COLUMNS|LAYOUT_FILL )
        
        # ------------------------------------------------------------------------------------ #
        
        FXLabel.new( matrix, "Courses:" )
        courses_listbox = FXListBox.new(matrix, :opts => LISTBOX_NORMAL|FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_X)
        select_course_btn = FXButton.new(matrix, "Refresh", :opts => BUTTON_NORMAL)
        
        courses_listbox.numVisible = 3
        
        courses  = [ "Programmering 1", "Energiteknik 1", "Gymnasiearbete" ]
        courses.each { |name| courses_listbox.appendItem(name) }
        
        # ------------------------------------------------------------------------------------ #
        
        FXLabel.new(matrix, "Assignments:")
        assignment_listbox = FXListBox.new(matrix, :opts => LISTBOX_NORMAL|FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_X)
        select_assignment_btn = FXButton.new(matrix, "Refresh", :opts => BUTTON_NORMAL)
        
        assignment_listbox.numVisible = 4
        assignment_listbox.appendItem("Guess-the-number")
        assignment_listbox.appendItem("Binär till decimal omvandlare")
        assignment_listbox.appendItem("Mastermind")
        
        assignment_listbox.connect(SEL_COMMAND) do |sender, sel, data|
            puts assignment_listbox.getItemText(data)
        end
        
        # ------------------------------------------------------------------------------------ #
        
        FXLabel.new(matrix, "Destination:")
        target_dir_textfield = FXTextField.new(matrix, 60)                 # number of columns will affect width of comboboxes (LAYOUT_FILL_X)
        set_target_dir_btn = FXButton.new(matrix, "New destination", :opts => BUTTON_NORMAL)
        
        set_target_dir_btn.connect(SEL_COMMAND) do
            dialog = FXDirDialog.new(self, "Select")
            if dialog.execute != 0
                target_dir_textfield.text = dialog.directory
            end
        end
        
        # ------------------------------------------------------------------------------------ #
        FXLabel.new(matrix, "Directory:")









        
        listview_frame = FXHorizontalFrame.new(v_frame, :opts => FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL|LAYOUT_TOP, :padding => 0)
        # list = FXList.new(listview_frame, :opts => LAYOUT_FILL)

        @table = FXTable.new(listview_frame, :opts => LAYOUT_FILL)
        #@table.setTableSize(20, 4)
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
        
        dir.each do |dir,|
            temp = File.mtime(dir)
            @table.setItemText(a, b, "#{wd}/#{dir}")
            @table.setItemJustify(a, 0, FXTableItem::LEFT)
            @table.setItemText(a, 3, "#{temp}")
            a += 1

            
        end







        #@table.setItemText(0, 0, "Is file?")
        #@table.setItemJustify(0, 0, FXTableItem::LEFT)
        #@table.setItemText(0, 1, "                 ")
        #@table.setItemJustify(0, 1, FXTableItem::LEFT)
        #@table.setItemText(0, 2, "2020-02-23 15:31:23")
        #@table.setItemJustify(0, 2, FXTableItem::LEFT)
        #@table.setItemText(0, 3, "LOL")
        #@table.setItemJustify(0, 3, FXTableItem::LEFT)

        # ------------------------------------------------------------------------------------ #
        
        text_frame = FXHorizontalFrame.new(v_frame, :opts => FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL|LAYOUT_TOP, :padding => 0)
        text_area = FXText.new(text_frame, :opts => TEXT_READONLY|LAYOUT_FILL)
        text_area.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit,\nsed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
    end
    
    def create
        super
        show(PLACEMENT_SCREEN)
        @table.fitColumnsToContents( 0 )
        @table.fitColumnsToContents( 1 )
        @table.fitColumnsToContents( 2 )

    end
end

if __FILE__ == $0
    FXApp.new do |app|
        ComboBoxExample.new(app)
        app.create
        app.run
    end
end