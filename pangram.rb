#!/usr/bin/ruby
$LOAD_PATH << '.'
require "converter"
include Converter

class Pangram
attr_accessor :prefix

def initialize(prefix)
	@prefix = prefix
end



def rand_in_range(x,y)
    range = (x - y).abs + 1
    rand(range) + [x,y].min
end

#Create and return a hash of the frequency of all the letters found in a given string of text.
def get_letter_count(word)
	word = word.downcase.gsub!(/[^a-z]/,"")
	word.scan(/\w/).inject(Hash.new(0)){|k, v| k[v] += 1; k}
end

#Takes a hash of letter counts as input and returns a self describing sentence with the values given.
def hash_to_sentence(letter_hash)
	sentence = prefix

	("a".."z").each do |letter|
		sentence += " and" if letter == 'z'
		sentence += " " + Converter.number_to_word(letter_hash[letter]).to_s + " '" + letter + "'"
		sentence += "s" unless letter_hash[letter] == 1
		letter == 'z' ? sentence+= '.' : sentence += ','
	end	
	sentence
end

def find_sentence
	start = Time.now #keep track of the timing.
	seed = prefix + "abcdefghijklmnopqrstuvwxyz" + "and"	#this will be used to build our hash of guessed letter counts.
	guess_hash = get_letter_count(seed)
	sentence = hash_to_sentence(guess_hash)
	actual_hash = get_letter_count(sentence)
	i = 0 

	#Robisonizing method to solve for correct sentence.
	#randomly change incorrect values.
	#create new sentence based on updated hash.
	#compare actual count to guessed count.

	while guess_hash != actual_hash

		i += 1
		("a".."z").each do |letter|
			if guess_hash[letter] != actual_hash[letter]
				guess_hash[letter] = rand_in_range(guess_hash[letter], actual_hash[letter])
			end
		end

		sentence = hash_to_sentence(guess_hash)
		actual_hash = get_letter_count(sentence)
	end

	execution = Time.now - start
	sentence + "\n\n" + i.to_s + " iterations" + "\n\n" + "execution time: " + execution.to_s + " seconds"
end

	p = Pangram.new("The solution to the CATS problem contains precisely")
	puts p.find_sentence
end