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
        id: 99999,
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
    end
  end
end
