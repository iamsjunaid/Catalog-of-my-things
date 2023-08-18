describe Game do
  let(:game_params) do
    {
      id: 1,
      publish_date: '2011-01-01',
      last_played_at: '2023-01-01',
      multiplayer: true
    }
  end

  subject(:game) { described_class.new(game_params) }

  before do
    allow(Date).to receive(:parse).and_call_original
    allow(Date).to receive(:parse).with('2023-01-01').and_return(Date.new(2023, 1, 1))
  end

  describe '#initialize' do
    it 'should create an instance of \'Game\' class' do
      expect(game).to be_an_instance_of(Game)
    end

    it 'sets default values for id, published_date, last_played_at and multiplayer' do
      expect(game.id).to be_a(Integer)
      expect(game.publish_date).to be_a(Date)
      expect(game.last_played_at).to be_a(Date)
      expect(game.multiplayer).to be_a(TrueClass) || be_a(FalseClass)
    end

    it 'sets the multiplayer attribute' do
      expect(game.multiplayer).to eq(game_params[:multiplayer])
    end

    it 'sets the last_played_at attribute' do
      expect(game.last_played_at).to eq(Date.new(2023, 1, 1))
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if parent method returns true and if last_played_at is older than 2 years' do
      game.last_played_at = Date.new(2020, 1, 1)
      expect(game.send(:can_be_archived?)).to be_truthy
    end

    it 'otherwise it will return false' do
      game2 = Game.new({
                         id: 1,
                         publish_date: '2011-01-01',
                         last_played_at: '2021-01-01',
                         multiplayer: true
                       })
      game3 = Game.new({
                         id: 1,
                         publish_date: '2020-01-01',
                         last_played_at: '2021-01-01',
                         multiplayer: true
                       })
      game4 = Game.new({
                         id: 1,
                         publish_date: '2020-01-01',
                         last_played_at: '2024-01-01',
                         multiplayer: true
                       })
      expect(game2.send(:can_be_archived?)).to be_falsey
      expect(game3.send(:can_be_archived?)).to be_falsey
      expect(game4.send(:can_be_archived?)).to be_falsey
    end
  end

  describe '#to_s' do
    it 'generates the correct string representation' do
      game_info = [
        "id: #{game.send(:id)}",
        "publish_date: #{game.send(:publish_date)}",
        "last_played_at: #{game.send(:last_played_at)}",
        "multiplayer: #{game.send(:multiplayer) ? 'yes' : 'no'}",
        "archived?: #{game.send(:can_be_archived?) ? 'yes' : 'no'}"
      ]
      expected_output = game_info.join(' | ')
      actual_output = game.instance_eval { to_s }
      expect(actual_output).to eq(expected_output)
    end
  end
end
