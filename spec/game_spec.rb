require 'rspec'
require_relative '../classes/game'
require_relative '../classes/item'

describe Game do
  let(:game_params) do
    {
      id: 1,
      publish_date: '2020-01-01',
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
    it 'sets the multiplayer attribute' do
      expect(game.multiplayer).to eq(game_params[:multiplayer])
    end

    it 'sets the last_played_at attribute' do
      expect(game.last_played_at).to eq(Date.new(2023, 1, 1))
    end
  end

  describe '#can_be_archived?' do
    context 'when last played recently' do
      it 'returns false' do
        allow(Date).to receive(:today).and_return(Date.new(2023, 8, 1))
        game.last_played_at = Date.new(2023, 8, 1)
        expect(game.send(:can_be_archived?)).to be_falsey
      end
    end

    context 'when last played more than 2 years ago' do
      it 'returns true' do
        allow(Date).to receive(:today).and_return(Date.new(2025, 1, 1))
        game.last_played_at = Date.new(2023, 1, 1)
        expect(game.send(:can_be_archived?)).to be_truthy
      end
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
