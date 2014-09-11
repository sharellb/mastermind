require 'yaml'

class MasterMind 

	def initialize
		@colors = ['w','y','o','p','b','g']
		@turns = 0 
		@game_over = false
		pick_pegs(@colors)
		rules
	end

	def play
		until @turns == 4 || @guess == @pegs 
			player_guess
			feedback
		end
		if @turns == 12
			puts "Sorry you're all out of turns."
			puts "The order was #{@pegs}"
		elsif @guess == @pegs 
			puts "YOU WON!"
		end
		play_again
	end

	def rules
		puts """
		You will be playing against the computer in this game.
		The computer will choose the order of 4 pegs of 6 different colors 
		(white, yellow, orange, purple, blue, and green).
		It's up to you to figure out the order and color of the pegs. 
		Colors can be reused or not used at all. You get 12 guesses.
		Don't worry. The computer will give you feedback after each guess.
		Good luck!
		"""
	end

	def pick_pegs(choices) 
		@pegs = []
		4.times do
			peg = choices.sample
			@pegs.push(peg)
		end
	end

	def player_guess 
		puts "Guesses used: #{@turns}"
		puts "Put in your guess separated by commas. Choose from w, y, o, p, b, or g."
		puts "Or type 'save' to save the game."
		@guess = gets.chomp
		if @guess == 'save'
			save
			exit(0)
		else
			@guess = @guess.split(",")
		end

		if @guess.length != 4
			puts "You didn't put in four pegs. Try again!" 
			player_guess
		elsif @guess.each do |x|
				if !@colors.include? x
					puts "#{x} is not a valid color. Try again!" 
					player_guess
				end
			end
		end 
	end

	def feedback 
		correct = 0 
		right_color = 0 
		for i in 0..3
			if @pegs[i] == @guess[i] 
				correct = correct + 1 
			elsif @guess.include? @pegs[i] 
				right_color = right_color + 1 
			end
		end
		puts "You have #{correct} in the right place."
		puts "You have #{right_color} of the right color but not in the correct place."
		puts " "
		@turns += 1
	end

	def play_again
		puts "Do you want to play again (y/n)?"
		play_response = gets.chomp
		if play_response == "y"
			game = MasterMind.new
			game.play
		elsif play_response == "n"
			puts "Thanks for playing!"
		else
			puts "You have to put y or n"
			play_again
		end
	end
end

def save #save the game as a yaml file into the games directory
	Dir.mkdir('games') unless Dir.exist? 'games'
	name = 'games/saved.yaml'
	File.open(name, 'w') do |file|
		file.puts YAML.dump(self)
	end
	puts "Game has been saved!"
end

def start_game
	puts "Welcome to Mastermind! Do you want to load an old game? (y/n)"
	old_game = gets.chomp
	if old_game == "y" #load old game
		content = File.open('games/saved.yaml', 'r') {|file| file.read }
		game = YAML.load(content) 
		game.play
	elsif old_game == "n" #start new game
		game = MasterMind.new
		game.play
	else
		puts "That's not an option. Try again!"
		start_game
	end
end

start_game









