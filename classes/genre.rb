class Genre
  def initialize(params)
    @id = params[:id] || Random.rand(1..100_000)
    @name = params[:name]
    @items = []
  end
end
