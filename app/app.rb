require_relative '../classes/author'
require_relative '../classes/genre'
require_relative '../classes/label'
require_relative '../classes/book'
require_relative '../classes/game'
require_relative '../classes/music_album'
require_relative '../modules/utils'

class App
  include Utils
  attr_reader :genres, :albums, :books, :labels, :games, :authors

  def initialize(params = { data_dir: 'data' })
    @data_dir = params[:data_dir]
    @authors = params[:authors] || load(:authors)
    @genres = params[:genres] || load(:genres)
    @labels = params[:labels] || load(:labels)
    @albums = params[:albums] || load(:albums)
    @books = params[:books] || load(:books)
    @games = params[:games] || load(:games)
  end

  def load(collection)
    [] unless %i[genres albums labels books games authors].include?(collection)

    file = FileHandler.new(folder: @data_dir)
    hash_objs = file.load(collection)
    generate(collection, hash_objs)
  end

  def generate(collection, src_objs)
    type = choose_type(collection)

    return generate_instances(src_objs, type) if %i[genre author label].include?(type)

    generate_items(src_objs, type)
  end

  def generate_items(params_collection, type)
    params_collection.map do |params|
      item = create_item(type, params)
      p params
    end
  end

  def generate_instances(params_collection, type)
    params_collection.map { |params| create_instance(type, params) }
  end

  def create_instance(type, params)
    case type
    when :genre
      Genre.new(params)
    when :author
      Author.new(params)
    when :label
      Label.new(params)
    end
  end

  def save(filename = :all)
    file = FileHandler.new(folder: @data_dir)
    file.save(send(filename), filename)
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

  def execute(option)
    targets = %i[books albums games genres labels authors]
    types = %i[book album game]

    case option
    when 1..6
      send(:list_all, targets[option - 1])
    when 7..9
      send(:add, types[option - 7])
    end
  end

  def list_all(target)
    return puts "Not able to list #{target}\n" unless respond_to?(target)

    if send(target).empty?
      puts "There are no #{target} to list"
      return
    end

    puts "List all #{target}"
    puts send(target) if respond_to?(target)
    puts "\n"
    true
  end

  def add(type)
    target = choose_target(type)
    return puts "Not able to create #{target} right now!\n" unless respond_to?(target)

    puts "Create a #{type == :album ? 'music album' : type}"
    params = ask_parameters(type)
    instances = {
      genre: Genre.new(params),
      author: Author.new(params),
      label: Label.new(params)
    }

    # create the type instance Book, MusicAlbum, Game
    new_item = create_item(type, params)
    puts "New [#{type}] was created..."
    send(target) << new_item if respond_to?(target)

    # set associations
    instances.each do |k, v|
      v.add_item(new_item)
      puts "#{k} and #{type} were succesfully associated..."
      send(choose_target(k)) << v if respond_to?(choose_target(k))
    end
    puts "\n"
    new_item
  end

  def create_item(type, params)
    case type
    when :album
      MusicAlbum.new(params)
    when :game
      Game.new(params)
    when :book
      Book.new(params)
    end
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

  def run
    loop do
      menu
      option = ask_for('1..10', 'to choose an option').to_i
      puts "\n"

      break if option.eql?(10)

      invalid unless (1..10).include?(option)

      execute(option) if (1..10).include?(option)
    end
    save(:authors)
    save(:genres)
    save(:labels)
    save(:albums)
    save(:books)
    save(:games)
    exit
  end
end
