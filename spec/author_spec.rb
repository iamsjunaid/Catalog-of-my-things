require 'rspec'
require_relative '../classes/author' # Make sure to adjust the path to the actual location of your Author class

describe Author do
  let(:author_params) { { first_name: 'John', last_name: 'Doe' } }
  let(:author) { Author.new(author_params) }
  let(:item) { double('item') }

  describe '#initialize' do
    it 'sets default values for id and items' do
      expect(author.id).to be_a(Integer)
      expect(author.items).to be_empty
    end

    it 'sets first_name and last_name' do
      expect(author.first_name).to eq('John')
      expect(author.last_name).to eq('Doe')
    end

    it 'sets provided id' do
      author_with_id = Author.new(author_params.merge(id: 123))
      expect(author_with_id.id).to eq(123)
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
