require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(params)
    super(params)
    @multiplayer = params[:multiplayer]
    @last_played_at = Date.parse(params[:last_played_at])
  end

  private

  def can_be_archived?
    super && last_played_old_enough?
  end

  def last_played_old_enough?
    current_date = Date.today
    years_since_last_played = current_date.year - @last_played_at.year
    years_since_last_played >= 2
  end

  def to_s
    properties = [
      "id: #{@id}",
      "publish_date: #{@publish_date}",
      "last_played_at: #{@last_played_at}",
      "multiplayer: #{@multiplayer ? 'yes' : 'no'}",
      "archived?: #{@archived ? 'yes' : 'no'}"
    ]

    properties.push("genre: #{@genre.name}") unless @genre.nil?
    properties.push("author first_name: #{@author.first_name} last_name: #{@author.last_name}") unless @author.nil?
    properties.push("label title: #{@label.title} color: #{@label.color}") unless @label.nil?

    properties.join(' | ')
  end
end