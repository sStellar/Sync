require_relative "FileObserver"
require_relative "print"
require "fox16"
include Fox

def init_vars(s_d= "../**/*")
  @spec_dir = s_d
  @fileob = FileObserver.new(@spec_dir)
  @fileob.readData()
  @new_files = []
  @del_files = []

  main_app = FXApp.new
  main_window = FXMainWindow.new(main_app, "File Sync", :width => 200, :height => 50)
  main_app.create
  main_window.show(PLACEMENT_SCREEN)
  main_app.run
end

def thread()
  t = Thread.new do
    new_file_inv = []
    n_f_v = Dir.glob(@spec_dir)
    n_f_v.each do |cur_file|
      if File.file?(cur_file)
        new_file_inv << cur_file
      end
    end
    i = 0 # fileob all files index
    sub_i = 0 # new files index

    # new files loop
    while i < @fileob.all_files.length
      while sub_i < new_file_inv.length
        if !@fileob.all_files[i].include?(new_file_inv[sub_i])
          # if file ob's all files does not include new files inv current file
          if !@new_files.include?(new_file_inv[sub_i])
            @new_files << new_file_inv[sub_i]
          end
          # add the new files inv current file to new files
        end
        sub_i += 1
      end
      i += 1
    end

    #del files loop
    i = 0
    sub_i = 0
    while i < new_file_inv.length
      while sub_i < @fileob.all_files.length
        if !new_file_inv[i].include?(@fileob.all_files[sub_i])
          # if new file invs current file does not include file obs current file
          if !@del_files.include?(@fileob.all_files[sub_i])
            @del_files << @fileob.all_files[sub_i]
          end
          # add the deleted file to del files
          # this works becuase new files inv is updated when the program starts
          # but file obs inv is outdated, if file is deleted, file obs inv still has it but not new files inv
        end
        sub_i += 1
      end
      i += 1
    end

    puts "mod times:"
    print_h @fileob.getModTimes()
    puts "edited:"
    p @fileob.getEdited
    puts "nfv:"
    p new_file_inv
    puts "new:"
    p @new_files
    puts "del:"
    p @del_files
  end
  t.join
end


init_vars()
thread()
