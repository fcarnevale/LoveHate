require 'spec_helper'
require 'vcr'
require 'vcr_helper'

feature 'Users can learn how good something is' do
  scenario 'User compares two terms' do
    terms = ["microsoft", "apple"]

    VCR.use_cassette("user-compares-two-terms") do
      terms.each do |term|
        @scores ||= {}
        @scores[term] = LoveScore.for_term(term)
      end

      @scores["apple"].should be > @scores["microsoft"]
    end
  end
end