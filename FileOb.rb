require 'yaml'
require_relative 'src/print'

class FileOb
  def initialize(spec_dir = Dir.pwd)
    @spec_dir = spec_dir
    @yaml_data = {}
    @file_inv = {}
    @new_files = []
    @edited_files = []
  end

  attr_reader :spec_dir, :file_inv, :new_files, :edited_files, :yaml_data

  def logic_func()
    # -------- Update File inventory with files and mod times and new files--------
    files = Dir.glob(@spec_dir + "/**/*")
    files.each do |file|
      if File.file?(file)
        mtime = File.mtime(file)
        if !@file_inv.has_key?(file)
          @new_files << file
        elsif mtime != @file_inv[file]
          if !@edited_files.include?(file)
            @edited_files << file
          end
        end
        @file_inv[file] = mtime
      end
    end
    return @file_inv
  end

  # -------- Save to and read from yaml --------

  def read_yaml(spec_dir = @spec_dir + "/data/data.yaml")
    begin
      @yaml_data = YAML.load(File.read(spec_dir))

      @file_inv = @yaml_data[:inv_data]
      @new_files = @yaml_data[:new_data]
      @edited_files = @yaml_data[:edited_data]
    rescue NoMethodError => e
      puts "No data to read"
      return false
    rescue => e
      puts e
    end
  end

  def save_yaml(spec_dir = @spec_dir + "/data/data.yaml")
    save_data = {
      "inv_data": @file_inv,
      "new_data": @new_files,
      "edited_data": @edited_files
    }
    begin
      File.read(spec_dir)
    rescue Errno::ENOENT => e
      puts e
      return false
    end
    File.open(spec_dir, "w") { |file| file.write(save_data.to_yaml) }
    return true
  end

end
