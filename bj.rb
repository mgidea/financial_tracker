#!/usr/bin/env ruby
# encoding: UTF-8
my_hand = []
dealer_hand = []
card_value = {}
my_score = 0
dealer_score = 0
SUITS = ['♠', '♣', '♥', '♦']
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
scores = [10,10,10,10,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,8,8,8,8,9,9,9,9,0,0,0,0,10,10,10,10,10,
  10,10,10,10,10,10,10]



def build_deck
  deck = []

  SUITS.each do |suit|
    VALUES.each do |value|
      deck.push(value + suit)
    end
  end

  deck.shuffle
end
deck = build_deck
sorted_deck = deck.sort
sorted_deck.each_with_index {|k,i|card_value[k] = scores[i]}
deck = build_deck
next_card = deck.pop
puts

def score (hand, hash)
  total = 0
  hand.each do |card|
  var = hash.fetch(card)
    if var == 0 && total < 11
      var = 11
    elsif var == 0 && total >= 11
      var = 1
    end
    total += var
  end
  total
end

def hit(card, hand, fifty_two)
  card = fifty_two.pop
  hand << card
end

hit(next_card, my_hand, deck)
hit(next_card, my_hand, deck)
hit(next_card, dealer_hand, deck)
hit(next_card, dealer_hand, deck)
my_score = score(my_hand, card_value)
dealer_score = score(dealer_hand, card_value)

puts "Welcome to Blackjack!"
puts
puts "Player was dealt #{my_hand[0]}"
puts "Player was dealt #{my_hand[1]}"
puts
puts "Player score: #{my_score}"
puts "Hit or stand (h/s): "
input = gets.chomp
puts
while input == "h"
  hit(next_card, my_hand, deck)
    puts "Player was dealt #{my_hand[-1]}"
    my_score = score(my_hand, card_value)
    puts "Player score: #{my_score}"
  if my_score > 21
    puts "Bust! You lose..."
    break
  end
  input = gets.chomp
end

if input == "s"
  puts
    puts "Player score: #{my_score}"
    puts
    puts
    puts  "Dealer was dealt #{dealer_hand[0]}"
    puts  "Dealer was dealt #{dealer_hand[1]}"
    puts  "Dealer score: #{dealer_score}"
    puts
  while dealer_score < 17
    hit(next_card, dealer_hand, deck)
      dealer_score = score(dealer_hand, card_value)
      puts  "Dealer was dealt: #{dealer_hand[-1]}"
      puts  "Dealer score: #{dealer_score}"
    if dealer_score > 21
      puts "Dealer busts, You win!"
    else
      puts
        puts "Dealer stands"
        puts
        dealer_score = score(dealer_hand, card_value)
        my_score = score(my_hand, card_value)
      if my_score == dealer_score
        puts "The game ends in a tie"
      elsif my_score < dealer_score
        puts "Sorry, the dealer wins"
      else
        puts "Congratulations, you win!"
      end
    end
  end
end




















