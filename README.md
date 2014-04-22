# Credit Card Processor

### Usage Instructions
Please run the following in your terminal to install required gems:
gem install rspec
gem install luhn-ruby

To run the tests, navigate to this directory in terminal and run 'rake'. This will run the rspec tests provided in /spec.

To run the program with your own input, please type input in input.txt (in the root directory). Then, in terminal, run 'ruby generate_report.rb'. The card summary will be printed to STDOUT.

### Design Decisions
I was not familiar with Luhn 10 before this project. I looked this up and found a few mathematical implementations I could use, but I decided to use a Ruby gem made for this exact purpose - https://github.com/rolfb/luhn-ruby

I wanted to modularize the card and processor functionality of this program, so that changes may be made to cards in the future that will not affect the processor, and vice-versa. The card class handles tracking of balance and user information, and validation. The processor is in charge of handling user input / output, and keeping / accessing a card list.

### Why Ruby?
Rspec is a great testing library, and Ruby is the language I am most technically proficient in.