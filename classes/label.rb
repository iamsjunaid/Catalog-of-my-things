class Label
  attr_reader :items, :id
  attr_accessor :color, :title

  def initialize(params)
    @id = params[:id] || Random.rand(1..1000)
    @title = params[:title]
    @color = params[:color]
    @items = []
  end

  def add_item(item)
    @items << item unless @items.include?(item)
    item.add_label(self)
  end

  private

  def to_s
    properties = [
      "id: #{@id}",
      "title: #{@title}",
      "color: #{@color}",
      "items (count): #{@items.size}"
    ]
    properties.join(' | ')
  end
end
