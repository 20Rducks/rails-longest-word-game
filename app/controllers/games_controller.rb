require "open-uri"
class GamesController < ApplicationController
  def new
    @randletters = ('a'..'z').to_a.sample(10)
  end

  def score
    word = params[:word]
    letters = params[:letters]
    correct = "Nice word! You made #{word} from #{letters}. that's a whole #{word.length} points."
    incorrect = "Sorry! You can't make #{word} from #{letters}"

    if english_word?(word)
      result = subset?(word.split(''), letters.split(' '))
      result ? @result = correct : @result = incorrect
    else
      @result = "#{word} isn't an English word, sorry!"
    end
  end

  private

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_checked = URI.open(url).read
    json = JSON.parse(word_checked)
    json['found']
  end

  def subset?(first, second)
    first.all? { |letter| second.include?(letter) }
  end
end
