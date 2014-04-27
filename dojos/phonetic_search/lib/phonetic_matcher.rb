#!/usr/bin/env ruby

module Phonetic

  def self.run
    matcher = PhoneticMatcher.new
    matcher.generate_surname_map $stdin.read.lines.map(&:chomp)
    puts ARGV
    ARGV.each do |name|
      puts "#{name} matches: #{(matcher.find_match name).join ','}"
    end
  end

  class PhoneticMatcher
    def initialize
      @equivalent_keys = [
        ['a','e','i','o','u'],
        ['c','g','j','k','q','s','x','y','z'],
        ['b','f','p','v','w'],
        ['d','t'],
        ['m','n']
      ]

      @surname_map = Hash.new
    end

    def alphabetise text
      text.gsub(/[^a-zA-Z ]/, '')
    end

    def discard text
      result = text[0]

      if text.length > 1
        result += text[1, text.length].gsub(/[aeiouhwy\s]/, '')
      end

      return result
    end

    def generate_match_key text
      text.squeeze.downcase.chars.map { |c| key_for_char c }.join
    end

    def key_for_char char
      @equivalent_keys.each_index { |i|
        if @equivalent_keys[i].include? char
          return i
        end
      }

      return (char == " " ? " " : "*")
    end

    def generate_surname_map surnames
      surnames.each { |surname|
        alph = alphabetise surname
        disc = discard alph

        key = generate_match_key disc
        if @surname_map.has_key? key
          @surname_map[key] << surname
        else
          @surname_map[key] = [surname]
        end
      }

      return @surname_map
    end

    def find_match name
      alph = alphabetise name
      disc = discard alph
      key = generate_match_key disc

      return @surname_map[key]
    end
  end
end

Phonetic.run if __FILE__ == $PROGRAM_NAME
