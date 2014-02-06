# To fetch word translation, we need open-uri to make requests to the API + JSON for parsing the response.
require 'open-uri'
require 'json'

# You may need global variables to store general stats (number of games played, avg score,...)
# Here are some examples, you're free to use your own and add new ones !
# Note : you could have used class variables instead.

class Game
	@nb_games = 0
  @avg_score = 0
  @total_points = 0

  # Which accessors do you need ?
  attr_accessor :grid, :message, :translation
  
  class << self
  	attr_accessor :nb_games, :avg_score, :total_points
  end

  def initialize
    # Which instance variables do initialize on a new object ?
    @start_time = Time.now
    @grid = ('A'..'Z').to_a.shuffle[0,9].join(' ')
  end

  def check!(guess)

  	if is_in_grid?(guess) == false
  		@message = "your input isn't in the grid"
  	elsif is_english?(guess) == false
  		@message = "your message is not in english."
  	else
  		score(guess)
  		@message = "your score is #{@score} points"
  	end

  end

  def stat
  	Game.total_points += @score
  	Game.nb_games += 1
  	Game.avg_score = (Game.total_points / Game.nb_games)
  end

  def score(guess)
  	@score = guess.length
  end

  def is_in_grid?(guess)
  	grid = @grid.dup.split(' ')
  	guess.upcase.each_char do |char|
  		return false unless grid.include?(char)
  			grid.delete_at(grid.index(char))
  	end
  	return true
  end

  def is_english?(guess)
  	response = open("http://api.wordreference.com/0.8/80143/json/enfr/#{guess.downcase}")
  	json = JSON.parse(response.read.to_s)
  	if json['Error']
  		return false
  	else
  		@translation = json['term0']['PrincipalTranslations']['0']['FirstTranslation']['term']
  	return true
  	end

  end

  
  # What is the public interface ?
    
  private
  # Methods that should be kept private

end