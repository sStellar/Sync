require_relative 'print'
class FileObserver
  def initialize
    @all_files = []
    @mod_times = {}
  end

  def getModTimes
    @all_files.each { |cur_file|
      @mod_times[cur_file] = File.mtime(cur_file)
    }
    return @mod_times
  end
  def getFiles
    @all_files = Dir.glob('**/*')
  end
end

x = FileObserver.new
p x.getFiles
print_h x.getModTimes
