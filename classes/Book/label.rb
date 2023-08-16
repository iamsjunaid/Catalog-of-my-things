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
  end
end
