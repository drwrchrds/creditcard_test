# gem from https://github.com/rolfb/luhn-ruby
require 'luhn'

class Card 
  attr_reader :name, :limit, :balance, :number
   
  def initialize(name, number, limit)
    @name, @number, @limit = name, Integer(number), Integer(limit[1..-1])
    @balance = 0
  end
  
  def number_valid?
    @number.to_s.length < 20 && Luhn.valid?(@number)
  end
  
  def balance
    number_valid? ? "$#{@balance}" : 'error'
  end
  
  def charge(amount)
    if number_valid?
      amount = Integer(amount[1..-1])
      @balance += amount unless @balance + amount > limit
    end
  end
  
  def credit(amount)
    if number_valid?
      @balance -= Integer(amount[1..-1])
    end
  end
  
  def to_s
    "#{name}: #{balance}"
  end
end


class Processor
  attr_accessor :cards
  
  def initialize
    @cards = {}
  end
  
  def add(name, number, limit)
    card = Card.new(name, number, limit)
    cards[name] = card
  end
  
  def charge(name, amount)
    cards[name].charge(amount)
  end
  
  def credit(name, amount)
    cards[name].credit(amount)
  end
  
  def print_summary
    cards.keys.sort.each { |name| puts cards[name] }
  end
  
  def input(string)
    input = string.split(' ')
    method = input.shift.downcase.to_sym
    self.send(method, *input)
  end
end


## start program

processor = Processor.new

input = "Add Tom 4111111111111111 $1000
Add Lisa 5454545454545454 $3000
Add Quincy 1234567890123456 $2000
Charge Tom $500
Charge Tom $800
Charge Lisa $7
Credit Lisa $100
Credit Quincy $200"

# input.split("\n").each do |line|
#   processor.input(line)
# end

# processor.print_summary