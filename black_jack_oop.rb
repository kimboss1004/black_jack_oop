# Black Jack: There is a Player. There is a Dealer. Two cards are dealed 
# to Player and Deealer in the beginning of the game. Objective is to get
# as close to 21 as possible. Anything above is bust/you lose. Player can 
# hit to get another card or check to stop. Than the Dealer serves himself
# cards until he is at or above 17. If he is above 21 he busts, but if not
# his cards are compared to yours and the closest one wins.

class Deck
  SUITS = ["Spades", "Hearts", "Clubs", "Diamonds"]
  CARDS = [2,3,4,5,6,7,8,9,10,'J','Q','K','A']
  attr_accessor :deck

  def initialize
    @deck = SUITS.product(CARDS).shuffle
  end

  def deal_card
    self.deck.pop
  end
end

  

class Players
  attr_accessor :name, :cards
  def initialize(n)
    @name = n
    @cards = []
  end

  def show_cards
    puts "#{self.name} has #{self.cards}. #{self.name}'s total is #{self.culculate_total}"
  end

  def culculate_total
    card_values = self.cards.map { |card| card[1]}
    total = 0
    card_values.each do |card|
      if(card == "A")
        total += 11
      elsif(card.to_i == 0)
        total += 10
      else
        total += card
      end
    end
    card_values.count{|x| x=="A"}.times do
      if(total > 21)
        total -= 10
      else
        break
      end
    end
    total
  end
end



class Game
  attr_reader :deck, :human, :dealer
  def initialize
    @deck = Deck.new
    @human = Players.new("Kim")
    @dealer = Players.new("Dealer")
  end

  def play
    puts "Cards being dealt ..."
    recieve_dealt_card(@human)
    recieve_dealt_card(@dealer)
    recieve_dealt_card(@human)
    recieve_dealt_card(@dealer)

    @human.show_cards
    @dealer.show_cards
    black_jack?(@human)

    hit_or_check(@human)
    hit_or_check(@dealer)

    puts "##########################################################"
    @human.show_cards
    @dealer.show_cards
    find_winner
  end

  def hit_or_check(player)
    if(player == @human)
    while (player.culculate_total < 21)
      begin
        puts "Would you like to hit? (y/n)"
        hit = gets.chomp
        if(hit != 'y' && hit != 'n')
          puts "error input. Try again"
        end
      end until ['y', 'n'].include?(hit)
      break if hit != 'y'
      recieve_dealt_card(player) if hit == 'y'
      player.show_cards
      black_jack?(player)
      bust?(player)
    end

    elsif player == @dealer 
      while(player.culculate_total < 17)
        recieve_dealt_card(player)
        player.show_cards
        black_jack?(player)
        bust?(player)
      end
    end
  end

  def recieve_dealt_card(player)
    player.cards<<@deck.deal_card
  end

  def black_jack?(player)
    if player.culculate_total == 21
      puts "$ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $"
      puts "#{player.name} got Black Jack!"
      exit
    end
  end

  def bust?(player)
      if player.culculate_total > 21
      puts "! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !"
      puts "#{player.name} Busted!"
      exit
    end
  end

  def find_winner
    if @human.culculate_total > @dealer.culculate_total
      puts "Congradulations, you Won!"
    elsif @human.culculate_total < @dealer.culculate_total
      puts "Sorry, you Lost!"
    else
      puts "It's a Tie!"
    end
  end

end


Game.new.play


















 

