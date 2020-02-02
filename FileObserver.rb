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

  def refreshFiles
    getFiles
    getModTimes
  end

  def helpMenu()
    puts ["help (h) - Prints this help menu",
      "clear (c) - Clear the screen",
      "all (a) - Prints and refreshes all files in current directory",
      "modified (m) - Prints and refreshes last modified times for files since files were last refreshed",
      "edited (e) - Starts edited function, any files edited since modified times was last refreshed",
      "refres (r) - Refreshes files and modified times, doesn't print anything"]
  end

  def commands(input)
    case input
    when "all", "a"
      puts getFiles()
    when "refresh", "r"
      refreshFiles
    when "modified", "m"
      print_h getModTimes()
    when "edited", "e"
      puts "Enter 'exit' to exit, regular commands work too"
      while true
        p getEdited
        e_input = gets.chomp
        if e_input === ""
        elsif e_input == "exit"
          break
        else
          commands(e_input)
        end
      end
    when "clear", "c"
      clear()
    when "help", "h"
      helpMenu()
    else
      puts "Sorry that doesnt seem to be a command, type 'help' to see available commands"
    end
  end
end

x = FileObserver.new
x.helpMenu
while true
  input = gets.chomp
  x.commands(input)
end
