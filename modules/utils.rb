require 'json'
module Utils
  class FileHandler
    def initialize(params)
      @data_folder = params[:folder] || 'data'
    end

    def full_path(filename = 'datafile.json')
      "#{@data_folder}/#{filename}.json"
    end

    def read_file(path)
      File.read(path)
    end

    def write_file(path, content)
      File.write(path, content)
      true
    end

    def make_dir(path)
      Dir.mkdir(path)
    end

    def dir_exist?(path)
      Dir.exist?(path)
    end

    def file_exist?(path)
      File.exist?(path)
    end

    def file_empty?(path)
      File.empty?(path)
    end

    def save(data, filename)
      make_dir(@data_folder) unless dir_exist?(@data_folder)
      opts = {
        array_nl: "\n",
        object_nl: "\n",
        indent: ' ',
        space_before: '',
        space: ' ',
        max_nesting: false
      }
      lines = data.map(&:to_json)
      file_content = JSON.pretty_generate(lines, opts)
      write_file(full_path(filename), file_content)
    end

    def load
      return [] unless file_exist?(full_path)
      return [] if file_empty?(full_path)

      file = read_file(full_path)
      file.split("\n")
    end
  end
end
