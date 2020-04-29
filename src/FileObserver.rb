require 'yaml'
require_relative 'print'

class FileObserver

  def initialize(spec_dir = "**/*")
    @all_files = []
    @mod_times = {}
    @edited_files = []
    @yaml_data = {}
    @spec_dir = spec_dir
    @new_files = []
    @del_files = []

    @pwd = Dir.pwd
  end

  attr_reader :all_files, :mod_times, :edited_files, :new_files, :del_files

  def getFiles()
    @all_files = []
    Dir.glob(@spec_dir).each do |cur_file|
      if File.file?(cur_file)
        @all_files << cur_file
      end
    end
    return @all_files
  end

  def getModTimes()
    @all_files.each do |cur_file|
      @mod_times[cur_file] = File.mtime( @pwd + cur_file )
    end
    return @mod_times
  end

  def getEdited()
    temp_edited = []
    @mod_times.each do |cur_file, cur_mod|
      if File.mtime(@pwd + cur_file) > cur_mod
        temp_edited << cur_file
      end
    end
    @edited_files = temp_edited
    return temp_edited
  end

  def getEditedArr()
    return @edited_files
  end

  def refreshFiles
    getFiles
    getModTimes
  end

  def thread(files)
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
      p files
      # new files loop
      while i < files.length
        while sub_i < new_file_inv.length
          if !files[i].include?(new_file_inv[sub_i])
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

      # del files loop
      i = 0
      sub_i = 0
      while i < new_file_inv.length
        while sub_i < files.length
          if !new_file_inv[i].include?(files[sub_i])
            # if new file invs current file does not include file obs current file
            if !@del_files.include?(files[sub_i])
              @del_files << files[sub_i]
            end
            # add the deleted file to del files
            # this works becuase new files inv is updated when the program starts
            # but file obs inv is outdated, if file is deleted, file obs inv still has it but not new files inv
          end
          sub_i += 1
        end
        i += 1
      end

    end
    t.join
  end
  def readData(dir = 'data/data.yaml')
    @yaml_data = YAML.load(File.read(dir))

    @all_files = @yaml_data[:file_data]
    @mod_times = @yaml_data[:mod_data]
    @edited_files = @yaml_data[:edited_data]
  end

  def saveData()
    file_data = @all_files
    mod_data = @mod_times
    edited_data = @edited_files
    save_data = {
      "file_data": file_data,
      "mod_data": mod_data,
      "edited_data": edited_data
    }
    File.open("data/data.yaml", "w") { |file| file.write(save_data.to_yaml) }
  end
#
end
