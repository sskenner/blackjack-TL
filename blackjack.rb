# interactive command line blackjack game

def calculate_total(cards)    # parameter:  [['H', '3'], ['C', 'K'], ... ]
  arr = cards.map{ |e| e[1] }

  total = 0
  arr.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0  # J, Q, K
      total += 10
    else
      total += value.to_i
    end
  end

  # check and correct for aces
  # identify how many aces we have
  arr.select{ |e| e == "A" }.count.times do
    total -= 10 if total > 21
  end

# if arr.include?("A") && total > 21
#    total -= 10
#  end

  total
end

# start of game

puts "welcome to blackjack"

suits = %w[H D S C]
cards = %w[2 3 4 5 6 7 8 9 10 J Q K A]

#deck = []
#suits.each do |suit|
#  cards.each do |card|
#    deck << [suit, card]
#  end
#end

deck = suits.product(cards)
deck.shuffle!

# deal cards

player_cards = []
dealer_cards = []

player_cards << deck.pop
dealer_cards << deck.pop
player_cards << deck.pop
dealer_cards << deck.pop

#puts "players:" + player_cards.to_s
#puts "dealers:" + dealer_cards.to_s

player_total = calculate_total(player_cards)
dealer_total = calculate_total(dealer_cards)


# show cards

puts "player has: #{player_cards[0]} and #{player_cards[1]}, for a total of #{player_total}"
puts "dealer has: #{dealer_cards[0]} and #{dealer_cards[1]}, for a total of #{dealer_total} "
puts ""

# player turn
if player_total == 21
  puts "you hit blackjack! .. YOU WIN"
  exit
end

while player_total < 21
  puts "what would you like to do?  (1) hit  or (2) stay"
  hit_or_stay = gets.chomp

  if !['1', '2'].include?(hit_or_stay)
    puts "error: please enter 1 or 2"
    next
  end

  # if stay
  if hit_or_stay == "2"
    puts "you choose to stay"
    break
  end

  # if hit
  new_card = deck.pop
  puts "#{new_card} dealt to player"
  player_cards << new_card
  player_total = calculate_total(player_cards)
  puts "player cards total is now: #{player_total}"

  if player_total == 21
    puts "player cards: "
    player_cards.map { |card| puts "=> #{card}" }
    puts "you hit blackjack! you win!"
    puts ""
    exit
  elsif player_total > 21
    puts "player cards: "
    player_cards.map { |card| puts "=> #{card}" }
    puts 'BUSTED .. you LOSE'
    puts ""
    exit
  end
end

# dealer turn
if dealer_total == 21
  puts "dealer's cards: "
  dealer_cards.map { |card| puts "=> #{card}" }
  puts "dealer hit blackjack! .. YOU LOSE"
  puts ""
  exit
end

while dealer_total < 17
  # hit
  new_card = deck.pop
  puts "#{new_card}  dealt to dealer"
  dealer_cards << new_card
  dealer_total = calculate_total(dealer_cards)
  puts "dealer cards total is now: #{dealer_total}"

  if dealer_total == 21
    puts "dealer's cards: "
    dealer_cards.map { |card| puts "=> #{card}" }
    puts "dealer hit blackjack! you LOSE!"
    puts ""
    exit
  elsif dealer_total > 21
    puts "dealer's cards: "
    dealer_cards.map { |card| puts "=> #{card}" }
    puts 'dealer BUSTED .. you WIN'
    puts ""
    exit
  end
end

# final hands

puts "dealer's cards: "
dealer_cards.map { |card| puts "=> #{card}" }
dealer_total = calculate_total(dealer_cards)
puts "dealer's cards total: #{dealer_total}"
puts ""
puts "player's cards: "
player_cards.map { |card| puts "=> #{card}" }
player_total = calculate_total(player_cards)
puts "player's cards total: #{player_total}"
puts ""

# compare cards

if dealer_total > player_total
  puts "dealer won .. YOU LOSE"
elsif dealer_total < player_total
  puts "YOU WIN"
else
  puts "it's a tie"
end

exit







































