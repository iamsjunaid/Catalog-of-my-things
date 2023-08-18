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

    def parse(objs)
      objs.map { |obj| JSON.parse(obj, { symbolize_names: true }) }
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

    def load(filename)
      return [] unless file_exist?(full_path(filename))
      return [] if file_empty?(full_path(filename))

      file = read_file(full_path(filename))
      objs = JSON.parse(file)
      parse(objs)
    end
  end

  def select_by(collection, params = {})
    return false if collection.empty? || params.empty?

    matches = []
    collection.find do |elem|
      matches = params.keys.map do |key|
        next unless elem.respond_to?(key)

        elem.send(key).eql?(params[key])
      end
      matches.all?
    end
  end

  def ask_for(type, message)
    type = type.to_s.capitalize if type.is_a?(Symbol)
    print "Type [#{type}] #{message}: "
    gets.chomp
  end

  def ask_parameters(type)
    parameters = {}
    parameters[:name] = ask_for(type, 'Genre name')
    parameters[:first_name] = ask_for(type, 'Author first name')
    parameters[:last_name] = ask_for(type, 'Author last name')
    parameters[:title] = ask_for(type, 'Label title')
    parameters[:color] = ask_for(type, 'Label color')
    parameters[:publish_date] = ask_for(type, 'publish date (yyyy/mm/dd)')

    case type
    when :book
      parameters[:publisher] = ask_for(type, 'publisher')
      parameters[:cover_state] = ask_for(type, 'cover state')
    when :album
      parameters[:on_spotify] = ask_for(type, 'is on spotify (y/n)').downcase == 'y'
    when :game
      parameters[:multiplayer] = ask_for(type, 'is multiplayer (y/n)').downcase == 'y'
      parameters[:last_played_at] = ask_for(type, 'was last played at (yyyy/mm/dd)')
    end

    parameters
  end

  def exit
    puts "\nThanks for using [ Catalog of Things ]...\nHave a nice day!"
  end

  def invalid
    puts "Invalid input, please try again\n"
    false
  end

  def choose_target(type)
    type.to_s.concat('s').to_sym
  end

  def choose_type(target)
    target.to_s.sub(/s$/, '').to_sym
  end

  def menu
    options = %w[books music_albums games genres labels authors book music_album game exit]
    puts "\nWelcome to your [ Catalog of Things ]"
    puts '-' * 60
    options.each_with_index do |name, i|
      case i
      when 0..5 then option = 'List all'
      when 6..8 then option = 'Add a'
      when 9 then option = 'Exit'
      end

      name = name.split('_').join(' ') if name.include?('_')
      puts "#{i + 1} - #{option}#{i < 9 ? " #{name}" : ''}"
    end
  end
end
