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

      it 'should have a valid \'id\' not \'nil\'' do
        expect(@new_genre_req.id).not_to be_nil
        expect(@new_genre_id.id).not_to be_nil
      end
    end
  end
end
