

#include "Card.h"
class Card
  
  def initialize(suit = nil, rank = nil, is_visible = true)
	  @m_visible = is_visible
    makeCardTextAndValue(suit, rank) unless suit == nil
  end

  def getCardText()
	  if (@m_visible)
		  return @m_card_text
    else
		  return "? ?? ???????"
    end
  end

  def setCardText(new_card_text)
    @m_cardText = new_card_text
  end

#/// <summary>This is a helper method to add two integer values together.
#/// <para>
#/// <see cref="System.Console.WriteLine(System.Int32)"/> for information
#/// about how to display the results.
#/// </para>
#/// <seealso cref="MyClass.Subtract"/>
#/// </summary>
  def toggleVisibility()
	  @m_visible = !@m_visible
  end

  def isVisible()
	  @m_visible
  end

  def makeCardTextAndValue(suit, rank)
	  card_suit = ""
		card_rank = ""
		case suit
    when 1 
      card_suit = "Spades"
    when 2
			card_suit = "Diamonds"
		when 3
			card_suit = "Clubs"
		when 4 
      card_suit = "Hearts"
    end
		case rank
		when 1
			card_rank = "A"
		  @m_card_value = 11
		when 2
			card_rank = "2"
			@m_card_value = 2
		when 3
			card_rank = "3"
			@m_card_value = 3
		when 4
			card_rank = "4"
			@m_card_value = 4
		when 5
			card_rank = "5"
			@m_card_value = 5
		when 6
			card_rank = "6"
			@m_card_value = 6
		when 7
			card_rank = "7"
			@m_card_value = 7
		when 8
			card_rank = "8"
			@m_card_value = 8
		when 9
			card_rank = "9"
			@m_card_value = 9
		when 10
			card_rank = "10"
			@m_card_value = 10
		when 11
			card_rank = "J"
			@m_card_value = 10
		when 12
			card_rank = "Q"
			@m_card_value = 10
		when 13
			card_rank = "K"
			@m_card_value = 10
    end
		@m_card_text = "#{card_rank} of #{card_suit}"
  end

  def getVal()
	  @m_card_value
  end
  
end