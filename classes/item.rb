require 'date'

class Item
  attr_reader :id, :genre, :label, :author
  attr_accessor :publish_date

  def initialize(params)
    @id = params[:id] || Random.rand(1...1000)
    @publish_date = Date.parse(params[:publish_date])
    @archived = params[:archived] || false
  end

  def add_genre(genre)
    @genre = genre
  end

  def add_label(label)
    @label = label
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end

  def to_json(*_args)
    hash = to_h
    hash[:genre_id] = @genre.id unless @genre.nil?
    hash[:author_id] = @author.id unless @author.nil?
    hash[:label_id] = @label.id unless @label.nil?

    hash.to_json
  end

  private

  def can_be_archived?
    current_date = Date.today
    year = current_date.year - @publish_date.year
    year > 10
  end

  def to_h(*_args)
    {
      id: @id,
      publish_date: @publish_date,
      archived: @archived
    }
  end
end
