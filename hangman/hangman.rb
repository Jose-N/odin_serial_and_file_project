require 'date'
require 'yaml'

class Hangman
  def initialize()
    @word = ""
    @triesLeft = 6
    @wrongLetters = ""
    @hiddenWord = ""
  end

  def newWord
    lines = File.readlines "5desk.txt"
    randLine = rand(0...61406)
    lines.each_with_index do |line,index|
      if index == randLine && line.length < 12 && line.length >5
        @word = line.chomp.downcase.to_s
        @word.length.times{ @hiddenWord << "*" }
      end
    end
  end

  def didWin
    win = false
    if @triesLeft == 0
      puts "You Lose!"
      puts "The correct word was: " + @word
      return win = true
    elsif @hiddenWord == @word
      puts "You Win!"
      return win = true
    end
  end

  def play
    puts "You have " + @triesLeft.to_s + " tries left!"
    #puts "Word:" + @word
    #puts @word.length.to_s
    puts "Hidden word: " + @hiddenWord
    puts "Wrong Letters: " + @wrongLetters
    puts "Please guess a letter:"  
    guess = gets.chomp.downcase.to_s  
    if @word.include? guess
      @word.each_char.with_index do |letter, index|
        if letter == guess
          @hiddenWord[index] = guess
        end
      end
    else 
      @triesLeft -= 1
      @wrongLetters << guess + " "
    end
  end
end

hangman = Hangman.new
puts "Would you like to load a game: Yes/No?"
response = gets.chomp.downcase.to_s
if response == "yes"
  listGames = Dir.glob("saves/*")
  puts listGames
  puts "What is the save file you want to open"
  saveFile = gets.chomp.to_s
  saveFileFull = "saves/" + saveFile
  oldGame = YAML.load(File.read(saveFileFull))
  until hangman.didWin
    hangman.play
    puts "Would you like to save your game: Yes/No?"
    save = gets.chomp.downcase.to_s
    if save == "yes"
      if Dir.exist?('saves')
        fileName = "saves/savegame" + DateTime.now.to_s + ".txt"
        File.open(fileName, 'w') { |f| f.write(YAML.dump(hangman))}
        puts "Your game has been saved"
      else
        Dir.mkdir "saves"
        puts "Made a saves folder"
        fileName = "saves/savegame" + DateTime.now.to_s + ".txt"
        File.open(fileName, 'w') { |f| f.write(YAML.dump(hangman))}
        puts "Your game has been saved"
      end
    end
  end
else
  hangman.newWord
  until hangman.didWin
    hangman.play
    puts "Would you like to save your game: Yes/No?"
    save = gets.chomp.downcase.to_s
    if save == "yes"
      if Dir.exist?('saves')
        fileName = "saves/savegame" + DateTime.now.to_s + ".txt"
        File.open(fileName, 'w') { |f| f.write(YAML.dump(hangman))}
        puts "Your game has been saved"
      else
        Dir.mkdir "saves"
        puts "Made a saves folder"
        fileName = "saves/savegame" + DateTime.now.to_s + ".txt"
        File.open(fileName, 'w') { |f| f.write(YAML.dump(hangman))}
        puts "Your game has been saved"
      end
    end
  end
end
