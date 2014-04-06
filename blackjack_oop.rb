
#deck #player #dealer

class Card

  attr_accessor :suite, :face_value

  def initialize(suite, face_value)
    @suite = suite
    @face_value = face_value
  end


   def pretty_output
    puts "The #{face_value} of #{suite}"
  end


end

module Hand


  def show_hand
    hand.each do |player_hand|
    player_hand.pretty_output
    end
  end


  def add_card(card)
    hand << card
  end

  def total
    total_hand = 0
    hand.each do |player_hand_value|

      if (player_hand_value.face_value == 'ace')
        total_hand += 11
      
      elsif (player_hand_value.face_value.to_i == 0)
        total_hand += 10
      
      else
      total_hand += player_hand_value.face_value
     
      end
      if (player_hand_value.face_value == 'ace' && total_hand >= 21)
        total_hand -=  10
       
      end
    end 
    return total_hand     
  end


  def is_busted?
    total > BlackJack::BLACKJACK_VALUE
  end

end


class Deck
  attr_accessor :cards

  def initialize 
  @cards = []

  suite = ['club', 'diamonds', 'hearts', 'spade']
  card_value = ['ace', 'jack', 'queen', 'king', 2, 3, 4, 5, 6, 7, 8, 9, 10]  

    suite.each do |card_suite|
     card_value.each do |card_value|
      @cards << Card.new(card_suite, card_value)
        end
      end
    @cards.shuffle!
  end



  def deal
    cards.pop
  end

end

class Player
   include Hand
   attr_accessor :name, :hand

  def initialize (name)
    @name = name
    @hand = []
  end

end


class Dealer
  include Hand
  attr_accessor :name, :hand

  def initialize
    @name = "Dealer"
    @hand = []
  end
end

class BlackJack
 BLACKJACK_VALUE = 21
 DEALERMIN = 17
  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new("Player_name")
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def get_name
    puts "What is your name?"
    player.name = gets.chomp

  end

  def deal_cards(player_or_dealer)
    player_or_dealer.add_card(deck.deal)
    
  end

    def print_total
    puts "The total is #{player.total}"
  end

  def deal_or_stay
    while !player.is_busted?
    puts "#{player.name}. Your total is #{player.total} Do you want to deal or stay? Enter D or S"
    answer = gets.chomp
    if (answer == "D")
      blackjack_or_bust(player)  
    elsif (answer == "S")
      puts "Dealer will play"
      blackjack_or_bust(dealer)
      break   
   else
      puts "You've entered an invalid value" 
  end
end # end while
end

def blackjack_or_bust(player_or_dealer)
  if (player_or_dealer.is_a? Player)
    deal_cards(player)
    player.show_hand
    puts "-----------------"
    if player.total > BLACKJACK_VALUE
    puts "#{print_total} You've been busted."
  end
elsif (player_or_dealer.is_a? Dealer)
  while dealer.total <= DEALERMIN
    deal_cards(dealer)  
  end 
  dealer.show_hand
  announce_winner 
end
end


def announce_winner
  if player.total > dealer.total
    puts "#{player.name} lost"
  elsif player.total == dealer.total
    puts "It's a draw"
  else
    puts "#{player.name} wins!"
  end
end


def run
  
  get_name
  deal_cards(self.player)
  deal_cards(self.player)
  player.show_hand
  deal_or_stay

end

end




game = BlackJack.new
game.run




