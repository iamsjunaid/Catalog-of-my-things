require 'date'

class Item
  def initialize(published_date, id, archived: false)
    @id = id.nil? || random.rand(1...1000)
    @published_date = Date.parse(published_date)
    @archived = archived
  end
end
