require_relative 'item'

class MusicAlbum < Item
  def initialize(params)
    super(params)
    @on_spotify = params[:on_spotify]
  end

  private

  def can_be_archived?
    super && @on_spotify
  end
end
