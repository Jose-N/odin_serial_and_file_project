class Hangman
  def initialize()
    @word = ""
    @hangman = ""
  end

  def newWord
    lines = File.readlines "5desk.txt"
    randLine = rand(0...61406)
    lines.each_with_index do |line,index|
      if index == randLine && line.length < 12 && line.length >5
        @word = line.chomp.downcase.to_s
      end
    end
  end

  def play
    hiddenWord = "" 
    wrongLetters = "" 
    triesLeft = 6
    @word.length.times{ hiddenWord << "*" }
    until triesLeft == 0 || hiddenWord == @word
      puts "You have " + triesLeft.to_s + " tries left!"
      #puts "Word:" + @word
      #puts @word.length.to_s
      puts "Hidden word: " + hiddenWord
      puts "Wrong Letters: " + wrongLetters
      puts "Please guess a letter:"  
      guess = gets.chomp.downcase.to_s  
      if @word.include? guess
        @word.each_char.with_index do |letter, index|
          if letter == guess
            hiddenWord[index] = guess
          end
        end
      else 
        triesLeft -= 1
        wrongLetters << guess + " "
      end
    end
    if triesLeft == 0
      puts "You Lose!"
    elsif hiddenWord == @word
      puts "You Win!"
    end
  end

end
hangman = Hangman.new
hangman.newWord
hangman.play
