
require 'yaml'
require_relative 'print'
require_relative 'FileObserver'

def helpMenu()
  puts ["help (h) - Prints this help menu",
    "clear (c) - Clear the screen",
    "all (a) - Prints and refreshes all files in current directory",
    "modified (m) - Prints and refreshes last modified times for files since files were last refreshed",
    "edited (e) - Starts thread for edited files",
    "read (r) - Read from data.yaml",
    "save (s) - Save to data.yaml"]
end

x = FileObserver.new
x.helpMenu
while true
  begin
  input = gets.chomp
  case input
  when "save", "s"
    x.saveData
  when "read", "r"
    print_h x.readData
  when "all", "a"
    x.allFilesThread
  when "modified", "m"
    x.modTimesThread
  when "edited", "e"
    x.editedThread
    while true
      edited_files = x.getEditedArr
      if edited_files != []
        p edited_files
      end
      sleep(3)
    end
  when "clear", "c"
    clear()
  when "help", "h"
    helpMenu()
  else
    puts "Sorry that doesnt seem to be a command, type 'help' to see available commands"
  end
  rescue => e
    puts "#{e.class}: #{e.message}"
  end
end
