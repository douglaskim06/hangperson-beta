class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(new_word)
  	@word = new_word
  	@guesses = ''
  	@wrong_guesses = ''
  end

  def guess(new_letter)
  	unless new_letter.to_s != ''
  		raise ArgumentError.new("Guess is empty or nil")
  	end
  	unless new_letter =~ /\A\p{Alnum}\z/
  		raise ArgumentError.new("Not a valid letter")
  	end
  	if @guesses.include? new_letter or @wrong_guesses.include? new_letter
  		return false
  	elsif @word.include? new_letter
  		@guesses << new_letter
  		return true
  	else
  		@wrong_guesses << new_letter
  		return 0
  	end

  end

  def word_with_guesses
  	i = 0
  	s = ''
  	while i < @word.length do
  		s << '-'
  		i += 1
  	end

  	i = 0
  	while i < @guesses.length do
  		wl = 0
  		while wl < @word.length do
  			if guesses[i] == word[wl]
  				s[wl] = guesses[i]
  			end
  			wl += 1
  		end
  		i += 1
  	end
  	return s
  end

  def check_win_or_lose
  	if !word_with_guesses.include? '-'
  		return :win
  	elsif @wrong_guesses.length >= 7
  		return :lose
  	else
  		return :play
  	end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
