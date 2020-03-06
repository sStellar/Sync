require 'yaml'
require_relative 'print'

class FileObserver

  def initialize
    @all_files = []
    @mod_times = {}
    @edited_files = []
    @yaml_data = {}
  end

  def getFiles()
    @all_files = []
    Dir.glob('**/*').each do |cur_file|
      if File.file?(cur_file)
        @all_files << cur_file
      end
    end
    return @all_files
  end

  def getModTimes()
    @all_files.each do |cur_file|
      @mod_times[cur_file] = File.mtime(cur_file)
    end
    return @mod_times
  end

  def getEdited()
    temp_edited = []
    @mod_times.each do |cur_file, cur_mod|
      if File.mtime(cur_file) > cur_mod
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

  def readData()
    @yaml_data = YAML.load(File.read('data.yaml'))
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
    File.open("data.yaml", "w") { |file| file.write(save_data.to_yaml) }
  end

  def allFilesThread()
    Thread.new do
      puts "Files inventory thread started."
      while true
        getFiles()
        sleep(3)
      end
    end
  end

  def modTimesThread()
    Thread.new do
      puts "Mod times thread started."
      while true
        getModTimes()
        sleep(3)
      end
    end
  end

  def editedThread()
    Thread.new do
      puts "Edited files thread started."
      while true
        getEdited()
        sleep (3)
      end
    end
  end
end
