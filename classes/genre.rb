class Genre
  def initialize(params)
    @id = params[:id] || Random.rand(1..100_000)
    @name = params[:name]
    @items = []
  end

  def add_item(item)
  end
end
