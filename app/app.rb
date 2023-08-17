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
      genre = select_by(send(:genres), { id: params[:genre_id] }) if params.include?(:genre_id)
      author = select_by(send(:authors), { id: params[:author_id] }) if params.include?(:author_id)
      label = select_by(send(:labels), { id: params[:label_id] }) if params.include?(:label_id)
      genre.add_item(item)
      author.add_item(item)
      label.add_item(item)
      item
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
