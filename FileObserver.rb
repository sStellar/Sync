require_relative 'print'
class FileObserver

  def initialize
    @all_files = []
    @mod_times = {}
    @edited_files = []
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

  def helpMenu()
    puts ["help (h) - Prints this help menu",
      "clear (c) - Clear the screen",
      "all (a) - Prints and refreshes all files in current directory",
      "modified (m) - Prints and refreshes last modified times for files since files were last refreshed",
      "edited (e) - Starts thread for edited files",
      "refresh (r) - Refreshes files and modified times, doesn't print anything"]
  end

end

x = FileObserver.new
x.helpMenu
while true
  input = gets.chomp
  case input
  when "all", "a"
    puts x.getFiles()
  when "refresh", "r"
    x.refreshFiles()
  when "modified", "m"
    print_h x.getModTimes()
  when "edited", "e"
    Thread.new do
      puts "Edited files thread started."
      edited_files = []
      while true
        x.getEdited
        edited_files = x.getEditedArr
        if edited_files != []
          p edited_files
        end
        sleep (3)
      end
    end
  when "clear", "c"
    clear()
  when "help", "h"
    x.helpMenu()
  else
    puts "Sorry that doesnt seem to be a command, type 'help' to see available commands"
  end
end
