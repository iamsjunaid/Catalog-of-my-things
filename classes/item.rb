require 'date'

class Item
  def initialize(params)
    @id = params[:id] || Random.rand(1...1000)
    @publish_date = Date.parse(params[:publish_date])
    @archived = params[:archived] || false
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end

  private

  def can_be_archived?
    current_date = Date.today
    year = current_date.year - @published_date.year
    year > 10
  end
end
