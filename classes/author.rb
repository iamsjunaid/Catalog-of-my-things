class Author
  attr_reader :id, :items
  attr_accessor :first_name, :last_name

  def initialize(params)
    @id = params[:id] || Random.rand(1..100_000)
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @items = []
  end

  def add_item(item)
    @items << item unless @items.include?(item)
    item.add_author(self)
  end

  private

  def to_s
    properties = [
      "id: #{@id}",
      "first_name: #{@first_name}",
      "last_name: #{@last_name}",
      "items (count): #{@items.size}"
    ]
    properties.join(' | ')
  end
end
