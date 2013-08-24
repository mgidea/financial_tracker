#!/usr/bin/env ruby
require 'date'
require 'csv'


def bounce_items(bottom_line, bounces, slot, amount, description, date)
  puts "#{bottom_line[slot]}, #{bounces[slot][amount]}, #{bounces[slot][description]}, #{bounces[slot][date]}"
end

balance = 0.00
total_income = 0.00
total_expenses = 0.00
total_overdraft_charges = 0.00
overdrafts = []
overdraft_particulars = []


CSV.foreach('transactions.csv', headers: true) do |row|
  balance += row[1].to_f
  if row[1].to_f > 0
    total_income += row[1].to_f
  elsif row[1].to_f.round(2) < 0
    total_expenses += row[1].to_f
  end
  if balance < 0.00 && row[1].to_f < 0.00
    balance -= 20.00
    total_overdraft_charges -= 20.00
    overdraft_particulars << balance.round(2)
    overdrafts << row
  end
end

puts "Ending Balance: #{balance.round(2)} "
puts "Total Income: #{total_income.round(2)}"
puts "Total Expenses: #{total_expenses.round(2)}"
puts "Total Overdraft Charges: #{total_overdraft_charges.round(2)}"

puts "Overdrafts (balance, expense, , date)"

puts

bounce_items(overdraft_particulars, overdrafts, 0 ,"amount","description","date")
bounce_items(overdraft_particulars, overdrafts, 1,"amount","description","date")
bounce_items(overdraft_particulars, overdrafts, 2 ,"amount","description","date")
bounce_items(overdraft_particulars, overdrafts, 3 ,"amount","description","date")






