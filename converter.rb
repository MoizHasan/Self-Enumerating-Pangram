module Converter


NUMBER_WORD_HASH = {
	90 => "ninety", 
	80 => "eighty",
	70 => "seventy",
    60 => "sixty",
    50 => "fifty",
    40 => "forty",
    30 => "thirty",
    20 => "twenty",
    19=>"nineteen",
    18=>"eighteen",
    17=>"seventeen", 
    16=>"sixteen",
    15=>"fifteen",
    14=>"fourteen",
    13=>"thirteen",              
    12=>"twelve",
    11 => "eleven",
    10 => "ten",
    9 => "nine",
    8 => "eight",
    7 => "seven",
    6 => "six",
    5 => "five",
    4 => "four",
    3 => "three",
    2 => "two",
    1 => "one"
}


WORD_NUMBER_HASH = NUMBER_WORD_HASH.invert #the inverse of our number word hash

def Converter.number_to_word(num)
    #this  method is used to convert a number into a String containing the word representation of that number
    # e.g. '5' t0 'five', '90' to ninety. 
    # for all numbers 1 to 99.

	if NUMBER_WORD_HASH.has_key? num
		NUMBER_WORD_HASH[num]
	else
	   digits = num.to_s.split('')
	   NUMBER_WORD_HASH[(digits[0] + '0').to_i] + '-' + NUMBER_WORD_HASH[(digits[1].to_i)]
	end
end

def Converter.word_to_number(word)
    if WORD_NUMBER_HASH.has_key? word
        WORD_NUMBER_HASH[word]
    else
        words = word.split('-')
        WORD_NUMBER_HASH[(words[0])] + WORD_NUMBER_HASH[words[1]]
    end
end

end