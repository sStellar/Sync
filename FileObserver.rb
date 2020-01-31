require_relative 'print'
class FileObserver

  def initialize
    @all_files = []
    @mod_times = {}
  end

  def getModTimes
    @all_files.each do |cur_file|
      @mod_times[cur_file] = File.mtime(cur_file)
    end
    return @mod_times
  end

  def getFiles
    @all_files = Dir.glob('**/*')
  end

  def getEdited
    edited_files = []
    @mod_times.each do |cur_file, cur_mod|
      if File.mtime(cur_file) > cur_mod
        edited_files << cur_file
      end
    end
    return edited_files
  end

end

x = FileObserver.new
p x.getFiles
print_h x.getModTimes
puts "edited #{x.getEdited}"
while true
  gets
  puts "edited #{x.getEdited}"
end
