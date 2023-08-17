require_relative 'item'

class Book < Item
  attr_accessor :cover_state, :publisher

  def initialize(params)
    super(params)
    @id = params[:id] || Random.rand(1..1000)
    @cover_state = params[:cover_state] || 'good'
    @publisher = params[:publisher] || 'Unknown'
  end

  private

  def can_be_archived?
    super || (@cover_state == 'bad')
  end

  def to_s
    properties = [
      "id: #{@id}",
      "publish_date: #{@publish_date}",
      "cover_state: #{@cover_state}",
      "publisher: #{@publisher}",
      "archived?: #{@archived ? 'yes' : 'no'}",
      "\n       "
    ]

    properties.push("genre: #{@genre.name}") unless @genre.nil?
    properties.push("author first_name: #{@author.first_name} last_name: #{@author.last_name}") unless @author.nil?
    properties.push("label title: #{@label.title} color: #{@label.color}") unless @label.nil?

    properties.join(' | ')
  end

  def to_h(*_args)
    super.merge({
                  cover_state: @cover_state,
                  publisher: @publisher
                })
  end
end
