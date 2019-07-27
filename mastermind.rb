class String
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def pink;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def yellow;           "\e[33m#{self}\e[0m" end

end
class Board
  def initialize
    @board_array = Array.new(12) { Array.new(4)}
    @tips = Array.new(12)
    12.times {|r|
      4.times {|l|
        @board_array[r][l] = ' '
      }
      @tips[r]  = ''
    }
    get_random_code()
    @round = 0
    @game_won = false
  end

  def show(display_str='')
    display_str += "┏━┳━┳━┳━┓\n"
    @board_array.each_with_index{|round, rindex|
      round_string = '┃'
      round.each_with_index{|location, lindex|
        lindex != 3 ? round_string +=  location + '┃'  : round_string += location + '┃'
      }
      round_string += "┣━╋━╋━╋━┫\n" unless rindex.zero?
      display_str += round_string + ' ' + @tips[rindex] + "\n"
    }
    display_str += "┗━┻━┻━┻━┛\n"
    puts display_str

  end

  def collored location
    case location
    when "y"
      location.upcase.yellow
    when "b"
      location.upcase.blue
    when 'g'
      location.upcase.green
    when 'r'
      location.upcase.red
    when 'p'
      location.upcase.pink
    when 'c'
      location.upcase.cyan
    else
      location
    end
  end

  def get_random_code 
    colors = ['Yellow','Blue','Green','Red','Pink','Cyan']
    picked_colors = []
    colors_chars = []
    4.times {
      picked_colors.push(colors.sample)
    }
    @colors = picked_colors
    picked_colors.each {|color|
      case color
      when "Yellow"
        colors_chars.push('y')
      when "Blue"
        colors_chars.push('b')
      when 'Green'
        colors_chars.push('g')
      when 'Red'
        colors_chars.push('r')
      when 'Pink'
        colors_chars.push('p')
      when 'Cyan'
        colors_chars.push('c')
      end
    }
    @colors_chars = colors_chars
  end

  def show_code_with_colors
    @colors.each {|color|
      case color
      when "Yellow"
        print 'Yellow '.yellow
      when "Blue"
        print 'Blue '.blue
      when 'Green'
        print 'Green '.green
      when 'Red'
        print 'Red '.red
      when 'Pink'
        print 'Pink '.pink
      when 'Cyan'
        print 'Cyan '.cyan
      end
    }
    puts ''
  end

  def right_chars? answer
    4.times do |char|
      if !(['y','b','g','r','p','c'].include? answer[char])
        return false
      end
    end
    true
  end



  def get_answer
    puts "Please Choice 4 Color Among " + 'Yellow '.yellow + 'Blue '.blue + 'Green '.green + 'Red '.red + 
    'Pink '.pink + 'Cyan '.cyan
    puts 'Type ' + 'Y '.yellow + 'B '.blue + 'G '.green + 'R '.red + 
    'P '.pink + 'C '.cyan
    answer = gets.chomp.downcase
    until answer.length == 4 && right_chars?(answer)
      puts "Please Choice 4 Color Among " + 'Yellow '.yellow + 'Blue '.blue + 'Green '.green + 'Red '.red + 
    'Pink '.pink + 'Cyan '.cyan
    puts 'Type ' + 'Y '.yellow + 'B '.blue + 'G '.green + 'R '.red + 
    'P '.pink + 'C '.cyan
    answer = gets.chomp.downcase
    end
    answer
  end

  def play_game
    while true 
      self.show
      player_answer = get_answer
      puts `clear`
      self.update_board(player_answer)
      if player_answer == @colors_chars.join()
        @game_won = true
        break
      elsif @round == 12
        self.show
        @game_won = false
        break
      end
      @tip = ['*','*','*','*']
      j = 0
      4.times {|i|
        if player_answer.include? @colors_chars[i]
          if @colors_chars[i] == player_answer[i]
            @tip[j] = 'O'
            j += 1
          else
            @tip[j] = 'X'
            j += 1
          end
        end
      }
      @tips[@round-1] = @tip.sort.join()

    end
    
    if @game_won == true
      puts 'You Won!'
      puts 'Colors Was:'
      self.show_code_with_colors
    else
      puts 'You Lost!'
      puts 'Colors:'
      self.show_code_with_colors
    end
  end


  def update_board(player_answer)
    @board_array[@round].each_with_index do |location,index|
      @board_array[@round][index] = collored(player_answer[index])
    end
    @round += 1
  end

end

def new_game
  board = Board.new
  board.play_game
end

def play_again?
  puts 'Play Again? Y/N'
  again_answer = nil
  again_answer = gets.chomp.downcase
  until again_answer == 'y' || again_answer == 'n'
    puts 'Play Again? Y/N'
    again_answer = gets.chomp.downcase
  end
  again_answer == 'y' ? true : false
end


while true
  new_game
  if !play_again?
    break
  end
end