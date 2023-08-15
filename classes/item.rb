require 'date'

class Item
  def initialize(published_date, id, archived: false)
    @id = id.nil? ? Random.rand(1...1000) : id
    @published_date = Date.parse(published_date)
    @archived = archived
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
