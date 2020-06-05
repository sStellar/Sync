require 'yaml'
require_relative 'print'

class FileOb
  def initialize(spec_dir = Dir.pwd)
    @spec_dir = spec_dir
    @yaml_data = {}
    @file_inv = {}
    @new_files = []
    @edited_files = []
    @del_files = []
  end

  attr_reader :spec_dir, :file_inv, :new_files, :edited_files, :del_files, :yaml_data

  # Internal: Creates a dict with all the files, in folders and subfolders.
  #                   Also creates a list with deleted, new, and edited files.
  #
  # spec_dir - Directory to find files in
  # files - Array of files in the directory
  # file, mtime - File name and last modified time
  #
  # Examples
  #   logic_func("/home/user/")
  #   # => {"folder/file.txt", 2020-04-03 14:30:22.446975683 +02:00}
  #
  # Returns the dictionary with file names and modified times
  def logic_func(spec_dir = @spec_dir)
    # -------- Update File inventory with files and mod times and new files--------
    files = Dir.glob(spec_dir + "/**/*")
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

    # -------- Deleted Files loop --------
    @file_inv.each do |file, time| # Time isn't used
      # if list of files doesnt include the file, add it to del files and remove it from file inv
      if !files.include?(file)
        if !@del_files.include?(file)
          @del_files << file
        end
        @file_inv.delete(file)
      end
    end

    return @file_inv
  end

  # -------- Save to and read from yaml --------
  # Internal: Redefines file dict, new, edited, and deleted files lists from data.yaml
  #
  # spec dir - Directory in which data.yaml is
  #
  # Examples
  #   read_yaml("/home/user/data")
  #   # => true
  #
  # Saves contents of data file to variables
  def read_yaml(spec_dir = @spec_dir)
    begin
      @yaml_data = YAML.load(File.read(spec_dir + "/data/data.yaml"))

      @file_inv = @yaml_data[:inv_data]
      @new_files = @yaml_data[:new_data]
      @edited_files = @yaml_data[:edited_data]
      @del_files = @yaml_data[:del_data]
    # NoMethodError if theres nothing in data.yaml
    rescue NoMethodError => e
      puts "No data to read"
      return false
    rescue => e
      puts e
    end
    return true
  end

  #Internal: Saves files dict, new, edited, and deleted files to data.yaml
  #
  # spec_dir - The folder in which the data file is
  # Examples
  #   save_yaml(/home/user/data)
  #   # => true
  #
  # Saves contents of variables to data file

  def save_yaml(spec_dir = @spec_dir)
    save_data = {
      "inv_data": @file_inv,
      "new_data": @new_files,
      "edited_data": @edited_files,
      "del_data": @del_files
    }
    begin
      # If it doesnt exist, Errno::ENOENT is cast
      File.read(spec_dir + "/data/data.yaml")
      # Write vars to data.yaml
      File.open(spec_dir + "/data/data.yaml", "w") { |file| file.write(save_data.to_yaml) }
    rescue Errno::ENOENT => e
      puts e
      puts "No such file: #{spec_dir}!"
      return false
    end
    return true
  end

end
