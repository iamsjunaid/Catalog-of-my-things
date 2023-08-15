require_relative '../classes/music_album'
require_relative '../classes/genre'

describe MusicAlbum do
  describe 'unit tests for \'MusicAlbum\' class' do
    before(:each) do
      # params to create a MusicAlbum instance
      music_album_params_req = {
        publish_date: '2020-01-01',
        on_spotify: true
      }
      @music_album_req = MusicAlbum.new(music_album_params_req)
      music_album_params_id = {
        id: 999_999,
        publish_date: '2023-08-01',
        on_spotify: true
      }
      @music_album_id = MusicAlbum.new(music_album_params_id)

      # params to create a Genre instance
      @genre_params_id = {
        id: 9999,
        name: 'music album genre'
      }
      @new_genre = Genre.new(@genre_params_id)
    end

    context 'when creating a new \'MusicAlbum\'' do
      it 'should create an instance of \'MusicAlbum\' class' do
        expect(@music_album_req).to be_an_instance_of(MusicAlbum)
        expect(@music_album_id).to be_an_instance_of(MusicAlbum)
      end

      it 'should inherits from \'Item\' class' do
        expect(@music_album_req).to be_kind_of(Item)
        expect(@music_album_id).to be_kind_of(Item)
        expect(@music_album_req.class.superclass).to eql(Item)
        expect(@music_album_id.class.superclass).to eql(Item)
      end
    end

    context 'when creating a new \'MusicAlbum\'' do
      it 'should have a valid \'id\' value' do
        expect(@music_album_req.id).not_to be_nil
        expect(@music_album_id.id).not_to be_nil
        expect(@music_album_req.id).to be_an_instance_of(Integer)
        expect(@music_album_id.id).to be_an_instance_of(Integer)
      end

      it 'should have a valid \'publish_date\' value' do
        expect(@music_album_req.publish_date).not_to be_nil
        expect(@music_album_id.publish_date).not_to be_nil
        expect(@music_album_req.publish_date).to be_an_instance_of(Date)
        expect(@music_album_id.publish_date).to be_an_instance_of(Date)
      end

      it 'should have a valid \'on_spotify\' value' do
        expect(@music_album_req.on_spotify).not_to be_nil
        expect(@music_album_id.on_spotify).not_to be_nil
        expect(@music_album_req.on_spotify).to be_kind_of(FalseClass).or be_kind_of(TrueClass)
        expect(@music_album_id.on_spotify).to be_kind_of(FalseClass).or be_kind_of(TrueClass)
      end
    end

    context 'when a \'Genre\' is set to a \'MusicAlbum\'' do
      it '\'MusicAlbum\' should have a valid \'genre\' property' do
        @new_genre.add_item(@music_album_req)
        @new_genre.add_item(@music_album_id)
        expect(@music_album_req.genre).not_to be_nil
        expect(@music_album_req.genre).to be_an_instance_of(Genre)
        expect(@music_album_id.genre).not_to be_nil
        expect(@music_album_id.genre).to be_an_instance_of(Genre)
      end

      it '\'MusicAlbum\' should be included in the \'items\' collection of \'Genre\'' do
        @new_genre.add_item(@music_album_req)
        @new_genre.add_item(@music_album_id)
        expect(@new_genre.items).to include(@music_album_req)
        expect(@new_genre.items).to include(@music_album_id)
      end
    end

    context '#can_be_archived? method' do
      it 'should exists and is \'private\'' do
        expect(@music_album_req.private_methods).to include(:can_be_archived?)
        expect(@music_album_req.private_methods(:can_be_archived?)).to be_truthy
      end

      context 'should return \'true\' if' do
        music_album1 = MusicAlbum.new({ publish_date: '2010-01-01', on_spotify: true })
        music_album2 = MusicAlbum.new({ publish_date: '2021-01-01', on_spotify: true })
        music_album3 = MusicAlbum.new({ publish_date: '2021-01-01', on_spotify: false })
        music_album4 = MusicAlbum.new({ publish_date: '2010-01-01', on_spotify: false })
        it 'parent\'s method return \'true\' AND \'on_spotify\' is \'true\'' do
          expect(music_album1.send(:can_be_archived?)).to be_truthy
        end
        it 'otherwise, should return \'false\'' do
          expect(music_album2.send(:can_be_archived?)).to be_falsy
          expect(music_album3.send(:can_be_archived?)).to be_falsy
          expect(music_album4.send(:can_be_archived?)).to be_falsy
        end
      end
    end
  end
end
