require 'spec_helper'
require 'vcr'
require 'vcr_helper'

feature 'Users can learn how good something is' do
  scenario 'User compares two terms' do
    terms = ["comcast", "the beatles"]

    VCR.use_cassette("user-compares-two-terms") do
      terms.each do |term|
        @scores ||= {}
        @scores[term] = ScoreCache.for_term(term)
      end

      @scores["the beatles"].should be > @scores["comcast"]
    end
  end
end