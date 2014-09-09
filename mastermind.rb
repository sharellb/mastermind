#mastermind


class MasterMind
	COLORS = ['w','y','o','p','b','g'] 

	attr_reader :game_over
	
	def initialize
		@turns = 0 
		rules
		pick_pegs(COLORS)
		until game_over
			player_guess
			feedback
			end_game
		end
		play_again
	end

	def rules
		puts " "
		puts "Welcome to Mastermind! You will be playing against the computer in this game."
		puts "The computer will choose the order of 4 pegs of 6 different colors (white, yellow, orange, purple, blue, and green)."
		puts "It's up to you to figure out the order and color of the pegs. Colors can be reused or not used at all. You get 12 guesses."
		puts "Don't worry. The computer will give you feedback after each guess."
		puts "Good luck!"
		puts " "
	end

	def pick_pegs(choices) 
		@pegs = []
		4.times do
			peg = choices.sample
			@pegs.push(peg)
		end
	end

	
	@game_over = false


	def player_guess 
		puts "Guesses used: #{@turns}"
		puts "Put in your guess separated by commas. Choose from w, y, o, p, b, or g."
		@guess = gets.chomp.split(",")
		if @guess.length != 4
			puts "You didn't put in four pegs. Try again!" 
			player_guess
		elsif @guess.each do |x|
				if !COLORS.include? x
					puts "#{x} is not a valid color. Try again!" 
					player_guess
				end
			end
		end
		@turns += 1 
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
	end

	def end_game
		if @turns == 12
			puts "Sorry you're all out of turns."
			puts "The order was #{@pegs}"
			@game_over = true
		elsif @guess == @pegs 
			puts "YOU WON!"
			@game_over = true
		end
		
	end

	def play_again
		puts "Do you want to play again (y/n)?"
		play_response = gets.chomp
		if play_response == "y"
			MasterMind.new
		elsif play_response == "n"
			puts "Thanks for playing!"
		else
			puts "You have to put y or n"
			play_again
		end
	end
end

MasterMind.new









