require_relative 'lib/cc_processor.rb'

processor = Processor.new

input = File.read("input.txt")

input.split("\n").each do |line|
  processor.input(line)
end

processor.print_summary