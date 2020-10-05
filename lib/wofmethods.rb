require 'pastel'

class WheelOfFortune
    attr_reader :puzzles
    attr_accessor :puzzle_selector
    attr_accessor :currentpuzzle
    attr_accessor :displayboard
    attr_accessor :letterinput
    attr_accessor :display
    attr_accessor :excludeddisplay
    attr_accessor :score
    def initialize
      #universal variable for colors
      @pastel = Pastel.new
  
      #temporary array for the puzzles until I get an array installed
      puzzles = ["Sleep tight, don't let the bed bugs bite!", "Who let the cat out of the bag?", "A Baker's Dozen", "Skeleton in the closet", "Saved by the bell", "A blessing in disguise", "A Bird In The Hand Is Worth Two In The Bush", "Bite Off More Than You Can Chew", "Call Me When You Get A Second"]
      @puzzles = puzzles

      #array of values that can be spun on the wheel
      wheel = [800, 500, 650, 500, 900, "Bankrupt", 5000, 500, 900, 700, 600, 800, 500, 700, 500, 600, 550, 500, 900, "Bankrupt", 650, 900, 700, 2500]
      @wheel = wheel
  
      #initializes the variable that contains the number that selects a puzzle from the array
      puzzle_selector = 0
      @puzzle_selector = puzzle_selector
      @puzzle_length = puzzles.length - 1
  
      #initializes the input, display, and score variables for gameplay
      letterinput = ""
      @letterinput = letterinput
      display = ""
      @display = display
      score = 0
      @score = score
  
      #arrays of vowels and consonants for the program to understand the difference. It needs to be able to tell when you spin if you are selecting a consonant or vowel, it also needs to be able to track when all vowels or consonants are chosen, it also needs to be able to detect when all the letters remaining in the puzzle are consonants or vowels, these arrays are helpers.
      vowels = ["a", "e", "i", "o", "u"]
      @vowels = vowels
      consonants = ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z"]
      @consonants = consonants
  
      #this arrays prevents special characters, or chosen characters from being displayed as "-"s
      excludeddisplay = [" ", ",", "!", "?", "'"]
      @excludeddisplay = excludeddisplay
  
      #a few more variables for getting the puzzle displayed (it needs to be chosen, converted into an array of letters, and then converted into an array of dashes, then progress tracks which letters are chosen and updates your current puzzle)
      puzzlenum = random_number
      currentpuzzle = puzzles[puzzlenum]
      @currentpuzzle = currentpuzzle
      random_number
      blank_puzzle
    end
  
    #displays title, border, blank line, the game board, another blank line and border, then another blank line.
    #Then displays your total score, and current options and calls the choose and option method.
    def play
      wheel_of_fortune_title
      game_board_border
      blank_link
      puts @gameboard
      blank_link
      game_board_border
      blank_link
      puts "Total: $#{@score}"
      blank_link
      choose_an_option
    end

    #Takes an input, determines whether to initiate spin, vowel, or solve
    #If spin, it will generate a 'turn value' for your spin
    #If you enter an invalid command it will simply reload your options
    def choose_an_option
      puts "Choose an option:"
      puts "Spin the wheel? (s) | Buy a Vowel? (v) | Solve the Puzzle? (sv)"
      @input = gets.strip.downcase
      if @input == "s" || @input == "spin"
          turn_value
          spin_wheel
        elsif @input == "v" || @input == "vowel"
          buy_vowel
        elsif @input == "sv" || @input == "solve"
          solve_puzzle
        else 
          play
      end
    end
  
    #The beautiful title!
    def wheel_of_fortune_title
      puts @pastel.red("
=================================================================")
  puts @pastel.yellow("
  
          ██╗    ██╗██╗  ██╗███████╗███████╗██╗                
          ██║    ██║██║  ██║██╔════╝██╔════╝██║                
          ██║ █╗ ██║███████║█████╗  █████╗  ██║                
          ██║███╗██║██╔══██║██╔══╝  ██╔══╝  ██║                
          ╚███╔███╔╝██║  ██║███████╗███████╗███████╗           
           ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝           
                                                               
                       ██████╗ ███████╗                        
                      ██╔═══██╗██╔════╝                        
                      ██║   ██║█████╗                          
                      ██║   ██║██╔══╝                          
                      ╚██████╔╝██║                             
                       ╚═════╝ ╚═╝                             
                                                               
  ███████╗ ██████╗ ██████╗ ████████╗██╗   ██╗███╗   ██╗███████╗
  ██╔════╝██╔═══██╗██╔══██╗╚══██╔══╝██║   ██║████╗  ██║██╔════╝
  █████╗  ██║   ██║██████╔╝   ██║   ██║   ██║██╔██╗ ██║█████╗  
  ██╔══╝  ██║   ██║██╔══██╗   ██║   ██║   ██║██║╚██╗██║██╔══╝  
  ██║     ╚██████╔╝██║  ██║   ██║   ╚██████╔╝██║ ╚████║███████╗
  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═══╝╚══════╝
  ")
  puts @pastel.red("
=================================================================
  ")
    end
  
    #Do you need a note to know this is the border?
    def game_board_border
      puts @pastel.blue("<o><o><o><o><o><o><o><o><o><o><o><o><o><o><o><o><o><o><o><o><o>")
    end
  
    #Literally a blank line.
    def blank_link
      puts "                               "
    end
  
    #generates a random number between 0 and -1 of the puzzle length (because arrays start at 0)
    #At one point I was getting a glitch so I added to_i to ensure the program knows this is an integer
    def random_number
      @randomnumber = rand(0..@puzzle_length)
      @randomnnumber = @randomnumber.to_i
    end
  
    #takes the current puzzles and splits it into an array of individual characters, and saves it to the array displayboard
    #initiates a new array called display
    #shovels the letter input into the excluddisplay array so whatever you input will no longer be made into dashes
    #calls display_board method
    def blank_puzzle
      @displayboard = @currentpuzzle.downcase.split(//)
      @remainingletters = @currentpuzzle.downcase.split(//)
      @display = []
      @excludeddisplay << @letterinput
      display_board
    end
  
    #iterates through each item in the display board array
    #if the character is not included in the excluded array, it should shovel a "-" into display
    #if the character is included in the excluded array (because it was already chosen or is an invalid option, such as punctuation) than it should shovel the character
    #this is what allows the board to update in the final variable when it joins
    def display_board
      @displayboard.each do |char| 
        if !@excludeddisplay.include?(char)
          @display << "-"
        else
          @display << char
        end
      end
      @gameboard = @display.join
    end
  
    #if the wheel doesn't spin bankrupt
    #tell them the turn value and let them choose a consonant
    #take the input, check if it is a vowel, if yes start over, if no see if their input was included in the excluded character array
    #if it was, they have already chosen this letter or it is an invalid option so make them choose again
    #if it is not, run the letter_in_puzzle method
    #if they did spin bankrupt, and their score isn't negative, make their score 0
    def spin_wheel
      if remaining_cons?
        if @turnvalue != "bankrupt"        
            puts "You spun $#{@turnvalue}! Choose a consonant"
            @letterinput = gets.strip.downcase
            if !@vowels.include?(@letterinput)
                if @excludeddisplay.include?(@letterinput) 
                spin_wheel
                else
                letter_in_puzzle
                end
            else
                spin_wheel
            end
        else
          puts "You spun $#{@turnvalue}!"
          if @score > 0
              @score = 0
          end
          choose_an_option
        end
      else
        puts "There are no remaining consonants."
        choose_an_option
      end
    end
  
    #selects a random element from the @wheel array
    def turn_value
        wheellength = @wheel.length - 1
        wheelpick = rand(0..wheellength)
        @turnvalue = @wheel[wheelpick]
    end

    def remaining_cons?
      #if @letterinput != nil
      #  inputindex = @remainingletters.index(@letterinput).to_i
      #end
      #print @remainingletters
      @remainingletters.each do |el|
        if @consonants.include?(el)
          #print "#{el}"
          if @letterinput != nil
            return true
          end
          return true
        end
      end
      return false
    end

    def remaining_vowels? 
      @remainingletters.each do |el|
        if @vowels.include?(el)
          #print "#{el}"
          if @letterinput != nil
            return true
          end
          return true
        end
      end
      return false
    end
    
    def letter_in_puzzle
      @display = []
      @excludeddisplay << @letterinput
      @puzzlecheck = @currentpuzzle.downcase
      multiplier = @puzzlecheck.count(@letterinput)
      puts @puzzlecheck
      @remainingletters.reject! { |x| x == @letterinput}
      if @puzzlecheck.include?(@letterinput)
        @score += (@turnvalue*multiplier)
      else
        @score -= @turnvalue
      end
      display_board
      play
    end
  
    def buy_vowel
      if remaining_vowels? 
        if @score >= 2500
          puts "Select a Vowel"
          @vowelchoice = gets.strip.downcase
          vowel_in_puzzle
        else
          puts " "
          puts "A vowel costs $2500, you can't afford a vowel right now."
          puts " "
          choose_an_option
        end
      else
        puts "There are no remaining vowels."
        choose_an_option
      end
    end
  
    def vowel_in_puzzle
      @display = []
      @excludeddisplay << @vowelchoice
      @score -= 2500
      display_board
      play
    end
  
    def solve_puzzle
      puts "Solve the Puzzle!"
      @solvethepuzzle = gets.strip.downcase
      if @solvethepuzzle == @currentpuzzle.downcase
        puts "YOU WIN!!! Total Prize: $#{@score}"
      else
        puts "That's not it, keep playing!"
        play
      end
    end
  end
  