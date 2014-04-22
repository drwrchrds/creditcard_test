require 'rspec'
require_relative 'spec_helper'
require 'braintree'

describe 'Card' do 
  let(:valid_card) { Card.new("Validia", "5454545454545454", "$3000") }
  let(:invalid_card) { Card.new("Invalidia", "1234567890123456", "$2000") }
  
  it 'validates card numbers with Luhn 10' do
    expect(valid_card.number_valid?).to be true
    expect(invalid_card.number_valid?).to be false
  end
  
  it 'starts with 0 balance' do
    expect(valid_card.balance).to eq("$0")
  end
  
  it 'displays "error" instead of balance if invalid' do
    expect(invalid_card.balance).to eq("error")
  end
end

describe 'Processor' do
  let(:processor) { Processor.new }
  
  describe 'Add' do
    it 'creates a new card for name, number, limit' do
      processor.add("Quincy", "5454545454545454", "$3000")
      quincy = processor.cards["Quincy"]
      
      expect(quincy.name).to eq("Quincy")
      expect(quincy.number).to eq(5454545454545454)
      expect(quincy.limit).to eq(3000)
    end
  end
  
  describe 'Charge' do
    before(:each) do
      processor.add("Quincy", "5454545454545454", "$3000")
      processor.charge("Quincy", "$500")
    end
    
    it 'increases the balance of the associated card by the amount specified' do
      expect(processor.cards["Quincy"].balance).to eq("$500")
    end
    
    it 'ignores charges that would raise the balance over the limit' do
      processor.charge("Quincy", "$3000")
      expect(processor.cards["Quincy"].balance).to eq("$500")
    end
    
    it 'ignores charges against invalid Luhn cards' do
      processor.add("Invalidia", "1234567890123456", "$3000")
      processor.charge("Invalidia", "$500")
      
      expect(processor.cards["Invalidia"]
            .instance_variable_get("@balance")).to equal(0)
    end
  end
  
  describe 'Credit' do
    it 'decreases the balance of associated card by the amount specified'
    
    it 'creates a negative balance if balance is dropped below 0'
    
    it 'ignores credits against Luhn 10 invalid cards'
  end
  
  describe 'Summary' do
    it 'is in the format "name: balance"' do
      processor.add("Quincy", "5454545454545454", "$3000")
      output = capture_stdout { processor.print_summary }
      expect(output).to eq("Quincy: $0\n")
    end
    
    it 'displays names alphabetically' do 
      processor.add("Quincy", "5454545454545454", "$3000")
      processor.add("Alicia", "1234567890123456", "$3000")
      processor.add("Zealia", "1234567890123456", "$3000")
      output = capture_stdout { processor.print_summary }
      
      first_name = output.split("\n")[0][0..5]
      last_name = output.split("\n")[2][0..5]
      
      expect(first_name).to eq("Alicia")
      expect(last_name).to eq("Zealia")
    end 
    
    
    it 'displays "error" instead of balance if invalid' do
      processor.add("Invalidia", "1234567890123456", "$3000")
      output = capture_stdout { processor.print_summary }
      
      expect(output.match(/\d/)).to be_nil
      expect(output.match('error')).not_to be_nil
    end
    
  end
  
  describe 'Getting input' do
    it 'parses a line of input and sends the right method' do
      expect(processor).to receive(:add)
      processor.input("Add Lisa 5454545454545454 $3000")
      
      expect(processor).to receive(:charge)
      processor.input("Charge Lisa $500")
    end
  end
  
end