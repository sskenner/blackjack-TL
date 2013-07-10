#> rvw assignment to include specs 

#deal_card: deal the cards to players
def deal
	random1 = rand(1..14)
	random2 = rand(1..14)

	# convert to royal court letter values
	# ?????? can simplify this ???????
	if random1 == 11
		random1 = 'J'
	elsif random1 == 12
		random1 = 'Q'
	elsif random1 == 13
		random1 = 'K'
	elsif random1 == 14
		random1 = 'A'
	end

	if random2 == 11
		random2 = 'J'
	elsif random2 == 12
		random2 = 'Q'
	elsif random2 == 13
		random2 = 'K'
	elsif random2 == 14
		random2 = 'A'
	end

	hand = [random1, random2]
end

#score: compute the score(s) of each player
def score hand
	total = 0

	hand.each do |cards|
		if cards == 'J' || cards == 'Q' || cards == 'K'
			total += 10
		elsif cards == 'A'
			if total >= 11
				total += 1
			else
				total += cards
			end
		end
		# ???? necessary to return total ?? or is it the last
		# evaluated .. 
		total
end

#game: play the game

#> how to clear screen
puts 'ruby blackjack'
	
cards = [1,2,3,4,5,6,7,8,9,10,11,12,13,14]

	# call deal function for players to get cards
dealer_hand = deal
player_hand = deal

	# print players cards
puts '>>> start game <<<'
puts 'dealer hand" ' + dealer_hand[0].to_s
puts 'player hand" ' + player_hand.to_s

	# compute to determine if player 21 on initial score 
puts '>>> running score <<<'
if score player_hand == 21
		puts '21! you win!'
		# option to play again
	play_again
elsif score dealer_hand == 21
	puts '21! dealer wins'
	play_again
end

puts score player_hand
	## determine if player wants a hit
puts "do you want a hit (type 'Y' or 'N')"
card_hit = gets.chomp
	## determine new score after hit
while card_hit == 'Y' || card_hit == 'y'
	hit player_hand

	puts '>>> new hand score <<<'
	puts player_hand
	puts score player_hand

		## determine win or bust after hit
	if (player_hand.length == 5) && (score player_hand < 21)
		puts 'less than 5 cards and under 21 .. U WIN!'
		play_again
	elsif bust player_hand == 1
		puts 'BUST .. U LOSE'
		play_again
	else
		puts "do you want a hit (type 'Y' or 'N')"
		card_hit = gets.chomp
	end
end

puts '>>> dealer turn'
if dealer_play dealer_hand == 'Hit'
	hit dealer_hand
	puts dealer_hand
else
	puts 'i am done'
	puts dealer_hand
end

		
#play_again: prompt to continue playing
def play_again
	puts "do you want to play again? (type 'Y' or 'N')"
	again = gets.chomp
	
	if again == 'Y' || again == 'y'
		game
	else
		puts '>>> laytaz <<<'
		# ???? need to break out loop ????
		# break
	end
end

	
#hit: deal cards based on players request
def hit hand
	new_card = rand(1..14)

	if new_card == 11
		new_card = 'J'
	elsif new_card == 12
		new_card = 'Q'
	elsif new_card == 13
		new_card = 'K'
	elsif new_card == 14
		new_card = 'A'
	end

	# need to manually return hand ??
	hand << new_card
end

#dealer_play: determine how the dealer plays
def dealer_play hand
	play = ''
	if score hand > 17
		play = 'stay'
	elsif score hand <= 17
		play = 'hit'
	# ??? need elsif or can just default to 'hit' ???
	play
	# ??? need to explicitely return play or will it be
	# the last value executed ??? 
	end
end

#winner: determine who wins
def winner hand1, hand2  # ??? need a wrapper? ???
  score1 = score hand1
  score2 = score hand2

  # ??? are ''s needed? for the return ???
  if score1 > 21
  	hand2
  elsif score2 > 21
  	hand1
  end

  if score1 > score2
  	hand1
  else
  	hand2
  end
end

#bust: determine who goes over 21

def bust hand
	if score hand > 21
		1
	else
		0
	end
	# ??? need explicit returns for 1 and 0 .. can use T/F
end

end