module Tennis
  class Game
    attr_accessor :player1, :player2

    def initialize
      @player1 = Player.new
      @player2 = Player.new

      @player1.opponent = @player2
      @player2.opponent = @player1
    end

    # Records a win for a ball in a game.
    #
    # winner - The Integer (1 or 2) representing the winning player.
    #
    # Returns the score of the winning player. 
    def wins_ball(winner)
      winner.record_won_ball!
    end

    # Announces current score with player1 serving
    # 
    # Returns deuce when both players have 3 points.
    # 
    # Checks for special cases when one player has 4 or more points, whether someone has won or play is in advantage.
    # 
    # Returns the score of each player together if none of the cases are true.
    def umpire_call
      if deuce?        
        "The score is deuce"
      elsif @player1.points >= 4 || @player2.points >= 4
        if @player1.points >= 4 && @player1.points >= @player2.points + 2
          "Player 1 has won"
        elsif @player2.points >= 4 && @player2.points >= @player1.points + 2
          "Player 2 has won"
        elsif advantage?
          "The score is advantage"
        end
      else
        "The score is " + "#{player1.score}" + "-" + "#{player2.score}"
      end
    end

    private

    # Check for advantage when player1 or player2 is up by one point
    def advantage?
      @player1.points >= 4 && @player1.points == (@player2.points + 1) ||
      @player2.points >= 4 && @player2.points == (@player1.points + 1)
    end

    # Check for deuce, when both players have 3 points
    def deuce?
      @player1.points == 3 && @player2.points == 3
    end
  end

  class Player
    attr_accessor :points, :opponent

    def initialize
      @points = 0
    end

    # Increments the score by 1.
    #
    # Returns the integer new score.
    def record_won_ball!
      @points += 1
    end

    # Returns the String score for the player.
    def score
      return 'love' if @points == 0
      return 'fifteen' if @points == 1
      return 'thirty' if @points == 2
      return 'forty' if @points == 3
    end
  end
end