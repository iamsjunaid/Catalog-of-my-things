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
end
