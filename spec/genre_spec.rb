require_relative '../classes/genre'

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
  end
end
