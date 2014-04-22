# Credit Card Processor

### Usage Instructions
To run the tests, navigate to this directory in terminal and run 'rake'. This will run the rspec tests provided in /spec.

You may need to install rspec first: 'gem install rspec'

To run the program with your own input, please type this in input.txt (in the root directory). Then, in terminal, run 'ruby generate_report.rb'. The summary will be printed out.

### Design Decisions
I was not familiar with Luhn 10 before this project. I looked this up and found a few mathematical implementations I could use, but I decided to use a Ruby gem made for this exact purpose - https://github.com/rolfb/luhn-ruby

I wanted to modularize the card and processor functionality of this program, so that changes may be made to cards in the future that will not affect the processor, and vice-versa. The card class handles tracking of balance and user information, and validation. The processor is in charge of handling user input / output, and accessing a card list (this is how I imagine a CC processor works in real life).

### Why Ruby?
Rspec is a great testing library, and Ruby is the language I am most technically proficient in.