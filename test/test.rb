require 'rubygems'
require 'bundler/setup'
require 'ebnf'
require 'ebnf/terminals'
require 'ebnf/peg/parser'

class Harness
    include EBNF::PEG::Parser

    def initialize
        ebnf = File.open(File.expand_path("../../grammar.ebnf", __FILE__))

        @rules = EBNF.parse(ebnf).make_peg.ast
    end

    def test(input)
        begin
            parse(input, :String, @rules)
            nil
        rescue EBNF::PEG::Parser::Error => e
            input + ":" + e.message
        end
    end
end

File.readlines('../strings.txt').each do |string|
    c = Harness::new();
    result = c.test(string)

    puts result if !result.nil?
end
