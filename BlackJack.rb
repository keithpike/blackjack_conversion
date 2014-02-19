#include "deck.h"
#include <iostream>
#include <conio.h>
#include <Windows.h>
#using namespace std;

#c++
#//Displays the root menu
#void displayMenu(int);
#void makeDeck(Deck *);
#void setupGame(vector<Card*> *, vector<Card*> *, Deck *, bool *, bool *);
#bool playBlackjack(int *, Deck *, Deck *);
#int calculateScore(vector<Card*> *);
#void displayHands(vector<Card*> *, vector<Card*> *);
#void reformDeck(Deck *, Deck *);
#bool didPlayerWin(int, int);

require_relative "Card"
require_relative "Deck"
# ruby


#### main()
	#//make cards/deck
  class BlackJack
    def initialize
      @draw_deck = Deck.new #// creates a deck with no cards in it
      @discard_deck = Deck.new
	    @wallet = 10    
    end
    
    def startBlackJack
	    makeDeck(@draw_deck)
      @draw_deck.setReshuffleCount(15)
      #//shuffle deck
      @draw_deck.shuffle()
      while (true) do
		    displayMenu(@wallet)
        #//wait for user's choice _getch()
        user_option_choice = gets.chomp
        case user_option_choice
        when "1"
          reformDeck(@draw_deck, @discard_deck)
        when "2"
			    #//shuffle cards in deck
          @draw_deck.shuffle
        when "3"
			    #//display all remaining cards in deck
          @draw_deck.displayCards
        when "4"
			    while (playBlackjack(@draw_deck, @discard_deck))
          end
        when "5"
			    #//quit
          exit
        else
			    #//if another letter/number is pressed, ignore
          break
        end
      end
    end
    
    def playBlackjack(draw_deck, discard_deck)
    	player_hand = []
      dealer_hand = []
    	player_score = 0
      dealer_score = 0
    	player_bust = false
    	dealer_bust = false
    	player_wager = 0
	
  
      #//show amount of money in your wallet
    	while (player_wager > @wallet || player_wager <= 0) do
    		print "How much of your $ #{@wallet} would you like to bet: " 
    		player_wager = gets.chomp.to_i
      end
    	#//deal cards
    	#//player cards are visible
    	#//show card type and rank
    	#//show total for hand
    	#//dealer cards are !visible
    	#//block out dealer's cards with #
    	setupGame(player_hand, dealer_hand, draw_deck, player_bust, dealer_bust)
    	#//check to see if player or dealer has 21
    	displayHands(dealer_hand, player_hand)
    	player_score = calculateScore(player_hand)
    	dealer_score = calculateScore(dealer_hand)
    	  if (player_score == 21 || dealer_score == 21)
    		  #//end hand and take or give money
    		  #//deduct amount bet from user
    		  #//send used cards to new deck for holding
    		  #//show menu to bet again
    		  dealer_hand[0].toggleVisibility
    		  displayHands(dealer_hand, player_hand)
    	  else
    		  user_choice = ' '
    		  user_stand = false
    		  while (player_score <= 21 && !user_stand) do
    			  print "\n[H]it\tor\t[S]tand\n"
    			  #//_getch() userChoice
    			  user_choice = gets.chomp.upcase
    			  if (user_choice == 'H')
    				  #//check to see if the deck has enough cards to continue
    				  reformDeck(draw_deck, discard_deck) if (draw_deck.isLow)
    					  #//move cards from discardDeck to drawDeck and shuffle
    					player_hand << (draw_deck.draw);
    				  #//display hands
    				  displayHands(dealer_hand, player_hand)
    				  player_score = calculateScore(player_hand)
    				  player_bust = true if (player_score > 21)
            elsif (user_choice == 'S')
    				  user_stand = true
            end
          end
    		  dealer_hand[0].toggleVisibility
    		  displayHands(dealer_hand, player_hand)
    		  while (dealer_score < 17 && player_bust != true) do
    			  #//check to see if the deck has enough cards to continue
    				  #//move cards from discardDeck to drawDeck and shuffle
    				reformDeck(draw_deck, discard_deck) if (draw_deck.isLow)
    			  dealer_hand << (draw_deck.draw)
    			  #//display hands
    			  displayHands(dealer_hand, player_hand)
    			  dealer_score = calculateScore(dealer_hand)
    			  dealer_bust = true if (dealer_score > 21)
          end
        end

    	  print "\nDealer Score: #{dealer_score}\nPlayer Score: #{player_score}\n\n"
	
    	if (dealer_bust || (player_bust == false && didPlayerWin(player_score, dealer_score)))
    		@wallet += player_wager
    	else
    		@wallet -= player_wager
      end
    	if (@wallet == 0)
    		#SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), 0x40);
    		puts "You're outta cash SUCKA!"
    		exit
      end

	
    	discard_deck.addCard(player_hand)
    	discard_deck.addCard(dealer_hand)
      #puts discard_deck.inspect
      #puts draw_deck.inspect
    	user_response = ' '
    	while (user_response != 'Y' && user_response != 'N') do
    		puts "Play another hand? (Y/N)"
    		user_response = gets.chomp.upcase
    		if (user_response == 'Y')
    			return true			
        end
      end
    	return false
    end
	
    def makeDeck(deck)
    	1.upto(4) do |x|
    		1.upto(13) do |y|
    			deck.addCard(Card.new(x, y))
        end
      end
      #puts deck.getTextInArray.inspect
    end

    def setupGame(player_hand, dealer_hand, deck, player_bust, dealer_bust)
    	player_bust = false
    	dealer_bust = false
    	dealer_hand << deck.draw
    	dealer_hand[0].toggleVisibility
    	player_hand << deck.draw
    	dealer_hand << deck.draw
    	player_hand << deck.draw
    end

    def displayMenu(players_pocket_money)
    	print "1. New Deck\n2. Shuffle cards in Deck\n3. Display all cards remaining in the Deck\n4. Play Blackjack\n5. Quit\n\nYou have $#{players_pocket_money}\n"
    end
    def calculateScore(hand)

    	total = 0
    	temp = 0
    	0.upto(hand.length - 1) do |x|
    		if (hand[x].getVal == 11)
    			temp += hand[x].getVal
    		else
    			total += hand[x].getVal
        end
      end

    	while ((temp + total) > 21) do
    		temp >= 11 ? temp -= 10 : break
      end
    	total += temp
    	total
    end

    def displayHands(dealer_hand, player_hand)
    	#//Create display function for hands
    	print "\nDealer"
    	0.upto(dealer_hand.length - 1) do |x|
    		print"\t:  #{dealer_hand[x].getCardText}\n"
      end
    	print "\nPlayer"
    	0.upto(player_hand.length - 1) do |x|
    		print "\t:  #{player_hand[x].getCardText}\n"
      end
    end

    def reformDeck(draw_deck, discard_deck)
    	#//make new deck
    	draw_deck.addCard(discard_deck.getCards)
      #puts discard_deck.getCards.inspect
      #puts draw_deck.getCards.inspect
    	#//purge discardDeck/drawDeck
    	discard_deck.purge
    	#//make cards/deck and shuffle
    	draw_deck.shuffle
    end
    def didPlayerWin(player_score, dealer_score)
    	if (player_score >= dealer_score)
    		return true
      end
    	return false
    end
  end

  game = BlackJack.new
  game.startBlackJack

