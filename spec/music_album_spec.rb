require_relative '../classes/music_album'

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
    end
  end
end
