module FileWriter
  class << self
    def write_path(base_path, write_path, wd, filename)
      File.expand_path(filename.gsub(base_path, File.expand_path(write_path, wd)))
    end

    def write_file(file_path, file_contents)
      response = FileUtils.mkdir_p(File.dirname(file_path))
      File.open(file_path, 'w+') { |f| f.write(file_contents) }
    end

    def write_files(files)
      files.each(&method(:write_file))
    end
  end
end
