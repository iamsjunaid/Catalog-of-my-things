require_relative '../classes/genre'
require_relative '../classes/item'

describe Genre do
  describe 'unit tests for \'Genre\' class' do
    before(:each) do
      # set the params to create a Genre instance
      @genre_params_req = {
        name: 'test genre'
      }
      @genre_params_id = {
        id: 1,
        name: 'test genre'
      }
      @new_genre_req = Genre.new(@genre_params_req)
      @new_genre_id = Genre.new(@genre_params_id)

      @genre_instance = instance_double(Genre)

      # create an Item instance
      item_params_id = {
        id: 1,
        publish_date: '2023-08-01'
      }
      @new_item = Item.new(item_params_id)
    end

    context 'when creating a new \'Genre\'' do
      it 'should create an instance of \'Genre\' class' do
        expect(@new_genre_req).to be_an_instance_of Genre
        expect(@new_genre_id).to be_an_instance_of Genre
      end

      it 'should have a valid \'id\' not \'nil\' but an \'Integer\'' do
        expect(@new_genre_req.id).not_to be_nil
        expect(@new_genre_id.id).not_to be_nil
        expect(@new_genre_req.id).to be_an_instance_of(Integer)
        expect(@new_genre_id.id).to be_an_instance_of(Integer)
      end

      it 'should have a valid \'name\' not \'nil\' but a \'String\'' do
        expect(@new_genre_req.name).not_to be_nil
        expect(@new_genre_id.name).not_to be_nil
        expect(@new_genre_req.name).to be_an_instance_of(String)
        expect(@new_genre_id.name).to be_an_instance_of(String)
      end

      it 'should not have any \'items\'' do
        expect(@new_genre_req.items).to be_empty
        expect(@new_genre_id.items).to be_empty
        expect(@new_genre_req.items).to be_an_instance_of(Array)
        expect(@new_genre_id.items).to be_an_instance_of(Array)
      end
    end

    context '#add_item method' do
      it 'should exists' do
        expect(@new_genre_req).to respond_to(:add_item)
      end

      it 'should receive one parameter as input, an \'Item\' instance' do
        allow(@genre_instance).to receive(:add_item).with(instance_of(Item)).exactly(1)
        @genre_instance.add_item(@new_item)
      end

      it 'should add the input \'Item\' to the collection of \'items\'' do
        @new_genre_req.add_item(@new_item)
        expect(@new_genre_req.items).to include(@new_item)
      end

      it 'should set \'Genre\' instance as a property of the input \'Item\' instance' do
        @new_genre_req.add_item(@new_item)
        expect(@new_item.genre).to be(@new_genre_req)
      end
    end
  end
end
