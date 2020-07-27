require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @arr = letters
  end

  def score

    @word = params[:word]
    @result = check(@word, params[:arr])


  end

  def letters
    times = rand(1..10)
    times.times.map{('a'..'z').to_a[rand(26)]}
  end

  def check(word, arr)

    unless arr.split(" ").sort.join.include? word.downcase.split("").sort.join
      return "Sorry, the word is not built on grid letters"
    else
      url = "https://wagon-dictionary.herokuapp.com/#{word}"
      user_serialized = open(url).read
      user = JSON.parse(user_serialized)
      if user["found"] == false
        return "This is not a vaild English word"
      else
        return "Congratulations! It is an English word!" 
      end
    end
  end
end


