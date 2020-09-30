
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
    puzzles = ["Sleep tight, don't let the bed bugs bite!", "Who let the cat out of the bag?", "A Baker's Dozen", "Skeleton in the closet", "Saved by the bell"]
    @puzzles = puzzles

    puzzle_selector = 0
    @puzzle_selector = puzzle_selector
    @puzzle_length = puzzles.length - 1

    letterinput = ""
    @letterinput = letterinput
    display = ""
    @display = display

    score = 0
    @score = score

    vowels = ["a", "e", "i", "o", "u"]
    @vowels = vowels

    excludeddisplay = [" ", ",", "!", "?"]
    @excludeddisplay = excludeddisplay

    puzzlenum = random_number
    currentpuzzle = puzzles[puzzlenum]
    @currentpuzzle = currentpuzzle
    random_number
    blank_puzzle
  end

  def play
    puts "Welcome to Wheel of Fortune!"
    puts "*******************************"
    puts "                               "
    puts @gameboard
    puts "                               "
    puts "*******************************"
    puts "Total: $#{@score}"
    puts "Choose an option:"
    puts "Spin the wheel? (spin) | Buy a Vowel? (vowel) | Solve the Puzzle? (solve)"
    @input = gets.strip.downcase
    if @input == "spin"
        turn_value
        spin_wheel
      elsif @input == "vowel"
        buy_vowel
      elsif @input == "solve"
        solve_puzzle
      else 
        play
    end
  end

  def random_number
    @randomnumber = rand(0..@puzzle_length)
    @randomnnumber = @randomnumber.to_i
  end

  def blank_puzzle
    @displayboard = @currentpuzzle.downcase.split(//)
    @display = []
    @excludeddisplay << @letterinput
    @displayboard.each do |char| 
      if !@excludeddisplay.include?(char)
        @display << "-"
      else
        @display << char
      end
    end
    @gameboard = @display.join
  end

  def spin_wheel
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
  end

  def turn_value
    @turnvalue = rand(250..2500)
  end

  def letter_in_puzzle
    @display = []
    @excludeddisplay << @letterinput
    @puzzlecheck = @currentpuzzle.downcase
    multiplier = @puzzlecheck.count(@letterinput)
    puts @puzzlecheck
    if @puzzlecheck.include?(@letterinput)
      @score += (@turnvalue*multiplier)
    else
      @score -= @turnvalue
    end
    @displayboard.each do |char| 
      if !@excludeddisplay.include?(char)
        @display << "-"
      else
        @display << char
      end
    end
    @gameboard = @display.join
    play
  end

  def buy_vowel
    if @score >= 2500
      puts "Select a Vowel"
      @vowelchoice = gets.strip.downcase
      vowel_in_puzzle
    else
      puts " "
      puts "A vowel costs $2500, you can't afford a vowel right now."
      puts " "
      play
    end
  end

  def vowel_in_puzzle
    @display = []
    @excludeddisplay << @vowelchoice
    @score -= 2500
    @displayboard.each do |char| 
      if !@excludeddisplay.include?(char)
        @display << "-"
      else
        @display << char
      end
    end
    @gameboard = @display.join
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

=begin
def blank_puzzle
    @displayboard = @currentpuzzle.downcase.split(//)
    @display = []
    @displayboard.each do |char| 
      if char != " " && char != "'" && char != "!" && char != "?" && char != ","
        @display << "-"
      else
        @display << char
      end
    end
    @gameboard = @display.join
  end
=end