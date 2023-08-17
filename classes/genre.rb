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

  def to_json(*_args)
    to_h.to_json
  end

  private

  def to_s
    properties = [
      "id: #{@id}",
      "name: #{@name}",
      "items (count): #{@items.size}"
    ]
    properties.join(' | ')
  end

  def to_h(*_args)
    {
      id: @id,
      name: @name
    }
  end
end
