require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = []
    @letters << ('a'..'z').to_a.sample until @letters.count == 10
  end

  def score
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_serialized = URI.open(url).read
    @word = JSON.parse(word_serialized)
    @input_word = params[:word]
    if @input_word.chars.all? { |a| @input_word.count(a) > @letters.count(a)}
      @response = "Sorry but #{@input_word} cannot be built out of #{@letters}"
    elsif @word["found"] == false
      @response = "Sorry but #{@input_word.upcase} does not seem to be an english word."
    else
      @response = "Congratulations! #{@input_word.upcase} is a valid word!"
    end
  end
end
