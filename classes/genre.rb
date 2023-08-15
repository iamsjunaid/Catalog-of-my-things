class Genre
  attr_reader :id, :items
  attr_accessor :name

  def initialize(params)
    @id = params[:id] || Random.rand(1..100_000)
    @name = params[:name]
    @items = []
  end

  def add_item(item)
    @items << item unless @items.include?(item)

    item.add_genre(self)
  end
end
