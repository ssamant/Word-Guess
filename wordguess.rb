#Completed this pair programming project with Aurora Anderson during our third week of Ada(!)

class Board

  attr_accessor :spaces

  def initialize(word, player_guess)
    @pond = []
    @frog = "____🐸____"
    @word = word
    @lilypad = "_________"
    @spaces = []
    @player_guess = player_guess
    create_board
    # @word ????
  end

  def create_board

    # CREATE POND
    @pond << @frog
    4.times do
      @pond << @lilypad
    end

    # CREATE SPACES
    @word.length.times do
      @spaces << "__"
    end
    # puts "created initial spaces"

  end

  def display_board

    # DISPLAY POND
    puts
    @pond.each do |space|
      print space + "  "
    end
    puts
    # puts "displaying pond"

    # DISPLAY SPACES
    puts
    @spaces.each do |space|
      print space + "  "
    end
    puts
    # puts "displaying spaces"

  end

  def update_board(counter, player_guess)

    # UPDATE POND
    # puts "updating pond"

    @pond.length.times do |n|
      if n < counter || n > counter
        @pond[n] = @lilypad
      else
        @pond[n] = @frog
      end
    end

    # PLEASE TELL US WHY THIS LOOP DIDN'T WORK
    # @pond.each_with_index do |space, index|
    #   if @counter == index
    #     space = @frog
    #   else
    #     space = @lilypad
    #   end
    # end

    # UPDATE SPACES
    # puts "before updating spaces, spaces is #{@spaces}"
    word_array = @word.split("")
    word_array.each_with_index do |letter, index |
      if letter == player_guess
        @spaces[index] = letter
      end
    end
    # puts "after updating, spaces is #{@spaces}"
  end

end


# TO DO:

# attr_accessors etc
# add faker for the @ word generation


class Game
  attr_accessor :word, :counter, :player_guess

  def initialize
    @player_guess
    @words = ["big", "small", "cat", "turtle"] #[some list of words]
    @counter = 0
    @word = @words.sample
    @letters_guessed = []
    @spaces
    @board = Board.new(@word, @player_guess)
    # puts "word is #{@word}."
    welcome_message
  end

  def welcome_message
    puts "\nWelcome to Frog Hop!"
    puts "Guess the correct letters in the word before the frog hops off your screen.\n\n"
    run_turn
  end


  def display_guessed_letters
    if @letters_guessed.length >0
      print "\nYou have guessed: "
      @letters_guessed[0..-2].each do |letter|
        print "#{letter}, "
      end
      print "#{@letters_guessed[-1]}.\n"
    end
  end

  def run_turn
    @board.display_board
    display_guessed_letters
    get_player_input
    check_if_game_over
    run_turn
  end

  def continue_or_quit
    print "\nWould you like to play again? (yes/no) "
    user_response = gets.chomp
    case user_response
    when "yes"
      @word = @words.sample
      @letters_guessed = []
      # puts "word is #{@word}."
      @board = Board.new(@word, @player_guess)
      run_turn
    when "no"
      exit
    else
      continue_or_quit
    end
  end


  def get_player_input
    print "\nPlease guess a letter: "
    @player_guess = gets.chomp
    puts "You guessed: #{@player_guess}."
    verify_guess_is_new
  end

  def verify_guess_is_new
    if @player_guess.length == 1
      #has it been guessed
      if @letters_guessed.include?(@player_guess)
        get_player_input
      else
        @letters_guessed << @player_guess # push new guess into old guesses array
        check_if_guess_is_right
      end
    else  #string is not one letter; gets another chance
      get_player_input
    end
  end

  def check_if_guess_is_right
    # puts "counter is now #{@counter}"

    if !@word.include? @player_guess
      @counter += 1
    end
    @board.update_board(@counter, @player_guess)

  end

  def check_if_game_over
    if @counter == 5
      puts "The frog got away! You lose. Wah-wah."
      continue_or_quit
    end
    if @board.spaces.join == @word
      puts "You win!"
      @board.display_board
      continue_or_quit
    end
    # puts "checked game over status and no result"
  end


end

new_game = Game.new
