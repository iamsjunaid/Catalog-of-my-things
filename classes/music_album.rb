require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(params)
    super(params)
    @on_spotify = params[:on_spotify]
  end

  private

  def can_be_archived?
    super && @on_spotify
  end

  def to_s
    properties = [
      "id: #{@id}",
      "publish_date: #{@publish_date}",
      "on_spotify: #{@on_spotify ? 'yes' : 'no'}",
      "archived?: #{@archived ? 'yes' : 'no'}"
    ]

    properties.push("genre: #{@genre.name}") unless @genre.nil?
    properties.push("author first_name: #{@author.first_name} last_name: #{@author.last_name}") unless @author.nil?
    properties.push("label title: #{@label.title} color: #{@label.color}") unless @label.nil?

    properties.join(' | ')
  end

  def to_h(*_args)
    super.merge({
                  on_spotify: @on_spotify
                })
  end
end
