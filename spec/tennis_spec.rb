require 'rubygems'
require 'pry'
require 'bundler/setup'
require 'rspec'


require_relative '../tennis'

describe Tennis::Game do
  let(:game) { Tennis::Game.new }

  describe '.initialize' do
    it 'creates two players' do
      expect(game.player1).to be_a(Tennis::Player)
      expect(game.player2).to be_a(Tennis::Player)
    end

    it 'sets the opponent for each player' do
      expect(game.player1.opponent).to eq(game.player2)
      expect(game.player2.opponent).to eq(game.player1)
    end
  end

  describe '#wins_ball' do
    it 'increments the points of the winning player' do
      game.wins_ball(game.player1)

      expect(game.player1.points).to eq(1)

      game.wins_ball(game.player2)

      expect(game.player2.points).to eq(1)

      game.wins_ball(game.player1)

      expect(game.player1.points).to eq(2)
    end
  end

  describe '#umpire_call' do
    context 'when score is forty-love' do
      it "calls out forty-love" do
        3.times { game.wins_ball(game.player1) }

        expect(game.umpire_call).to eq("The score is forty-love")
      end
    end

    context 'when score is deuce' do
      it 'calls out deuce' do
        3.times { game.wins_ball(game.player1) }
        3.times { game.wins_ball(game.player2) }

        expect(game.umpire_call).to eq("The score is deuce")
      end
    end

    context 'when score is advantage for player1' do
      it 'calls out advantage' do
        3.times { game.wins_ball(game.player1) }
        4.times { game.wins_ball(game.player2) }

        expect(game.umpire_call).to eq("The score is advantage")
      end
    end

    context 'when score is advantage for player2' do
      it 'calls out advantage' do
        3.times { game.wins_ball(game.player2) }
        4.times { game.wins_ball(game.player1) }

        expect(game.umpire_call).to eq("The score is advantage")
      end
    end

    context 'when player1 wins' do
      it 'calls out player1 has won' do
        6.times { game.wins_ball(game.player1) }
        4.times { game.wins_ball(game.player2) }

        expect(game.umpire_call).to eq("Player 1 has won")   
      end
    end 

    context 'when player2 wins and player1 has no points' do
      it 'calls out player2 has won' do
        4.times { game.wins_ball(game.player2) }

        expect(game.umpire_call).to eq("Player 2 has won")
      end
    end
  end
end

describe Tennis::Player do
  let(:player) do
    player = Tennis::Player.new
    player.opponent = Tennis::Player.new

    return player
  end

  describe '.initialize' do
    it 'sets the points to 0' do
      expect(player.points).to eq(0)
    end 
  end

  describe '#record_won_ball!' do
    it 'increments the points' do
      player.record_won_ball!

      expect(player.points).to eq(1)
    end
  end

  describe '#score' do
    context 'when points is 0' do
      it 'returns love' do
        expect(player.score).to eq('love')
      end
    end
    
    context 'when points is 1' do
      it 'returns fifteen' do
        player.points = 1

        expect(player.score).to eq('fifteen')
      end 
    end
    
    context 'when points is 2' do
      it 'returns thirty'  do
        player.points = 2

        expect(player.score).to eq('thirty')
      end
    end
    
    context 'when points is 3' do
      it 'returns forty' do
        player.points = 3

        expect(player.score).to eq('forty')
      end
    end
  end
end