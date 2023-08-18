describe Author do
  let(:author_params) { { first_name: 'John', last_name: 'Doe' } }
  let(:author) { Author.new(author_params) }
  let(:item) { double('item') }

  describe '#initialize' do
    it 'should create an instance of \'Author\' class' do
      expect(author).to be_an_instance_of(Author)
    end

    it 'sets default values for id and items' do
      expect(author.id).to be_a(Integer)
      expect(author.items).to be_a(Array)
      expect(author.items).to be_empty
    end

    it 'sets first_name and last_name' do
      expect(author.first_name).to eq('John')
      expect(author.first_name).to be_a(String)
      expect(author.last_name).to eq('Doe')
      expect(author.last_name).to be_a(String)
    end

    it 'sets provided id' do
      author_with_id = Author.new(author_params.merge(id: 123))
      expect(author_with_id.id).to eq(123)
    end

    it 'sets provided first name' do
      author_with_first_name = Author.new(author_params.merge(first_name: 'John'))
      expect(author_with_first_name.first_name).to eq('John')
    end

    it 'sets provided last name' do
      author_with_last_name = Author.new(author_params.merge(last_name: 'Doe'))
      expect(author_with_last_name.last_name).to eq('Doe')
    end
  end

  describe '#add_item' do
    it 'adds an item to the author and associates the author with the item' do
      item = double('item')
      allow(item).to receive(:add_author)
      author.add_item(item)
      expect(author.items).to include(item)
      expect(item).to have_received(:add_author).with(author)
    end

    it 'does not add the same item again' do
      item = double('item')
      allow(item).to receive(:add_author)
      author.add_item(item)
      expect(author.items).to eq([item])
      expect(item).to have_received(:add_author).once
    end
  end

  describe '#to_s' do
    before do
      @author = Author.new(author_params)
    end

    it 'returns a string representation of the author' do
      author_string = author.send(:to_s)
      expect(author_string).to include("id: #{author.id}")
      expect(author_string).to include("first_name: #{author.first_name}")
      expect(author_string).to include("last_name: #{author.last_name}")
      expect(author_string).to include("items (count): #{author.items.size}")
    end
  end
end
