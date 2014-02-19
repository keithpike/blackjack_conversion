#include "Deck.h"
require_relative "Card"
require "time"

class Deck
  def initialize(p_new_cards = nil)
    srand()
    @cards_in_deck = []
    @count = 0
    @reshuffle_count = 15
    0.upto(51) do |x|
      @cards_in_deck[x] = nil
    end
    if (p_new_cards != nil)
      addcards(p_new_cards)
    end
  end
  
  def shuffle()		#// Postcondition: Cards in the deck are placed in a random order
    hold = nil
    0.upto(@count - 1) do |x|
      random_card = rand((@count - 1 + 0) + 0) % @count
      hold = @cards_in_deck[x];
      @cards_in_deck[x] = @cards_in_deck[random_card]
		  @cards_in_deck[random_card] = hold
    end
  end

  def draw()
    if(@count > 0)
		  ret = @cards_in_deck[0]
    
      0.upto(@count - 1) do |x|
			  @cards_in_deck[x] = @cards_in_deck[x + 1]
      end
      @count -= 1
		  ret
    else
		  nil
    end
  end

  def addCard(*p_new_cards)			#// Postcondition: Adds all cards in the vector to the deck
    p_new_cards.flatten.each do |new_card|
      if(new_card != nil)
        @cards_in_deck[@count] = new_card
			  @count += 1
      end	
    end
  end

  def getCards()	#// Postcondition: Returns all cards in deck as a vector of Card pointers
	  @cards_in_deck
  end

  def purge() #//Postcondition: Removes all cards from the deck
    @cards_in_deck.each do |the_card|
      the_card = nil
    end
    @count = 0
  end

  def displayCards()
    @cards_in_deck.each do |the_card|
      #puts the_card.class
		  puts the_card.getCardText if the_card != nil
    end
  end
  
  def getTextInArray()
    some_array = []
    @cards_in_deck.each do |the_card|
		   some_array << the_card.getCardText
    end
   # puts @cards_in_deck.inspect
   # puts @cards_in_deck.length
    some_array

  end

  def isLow()
    if (@count < @reshuffle_count)
		  return true
	  else
		  return false
    end
  end
  
  def setReshuffleCount(num)
	  @reshuffle_count = num
  end
end
  
