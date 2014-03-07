require 'spec_helper'

feature 'Users can learn how good something is' do
  scenario 'User compares two terms' do

    terms = ["microsoft", "apple"]

    terms.each do |term|
      @scores ||= {}
      @scores[term] = LoveScore.for_term(term)
    end

  end
end