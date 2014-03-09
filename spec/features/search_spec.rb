require 'spec_helper'
require 'vcr'
require 'vcr_helper'

feature 'Users can learn how good something is' do
  let(:terms) {["comcast", "the beatles"]}

  scenario 'Compare two terms' do
    VCR.use_cassette("compare-two-terms") do
      terms.each do |term|
        @scores ||= {}
        visit query_path(term: term)
        score = ActiveSupport::JSON.decode(page.source).fetch("score")
        @scores[term] = score
      end

      @scores["the beatles"].should be > @scores["comcast"]
    end
  end

  scenario 'Search for cached term' do
    CachedScore.save_score("microsoft", 2.5)
    
    last_term  = CachedScore.last.term
    last_score = CachedScore.last.score
    
    last_term.should eq "microsoft"
    last_score.should eq 2.5
  end

  scenario 'Search for term with no score' do
    VCR.use_cassette("search-for-term-with-no-score") do
      visit query_path(term: 'asdfasdflkajlsdkjdlkjaslkj')
      score = ActiveSupport::JSON.decode(page.source).fetch("score")

      score.should be_nil
    end
  end

  scenario 'Search for cached term with no score' do
    CachedScore.save_score("microsoft", LoveScore::NoScore)
    visit query_path(term: 'microsoft')
    score = ActiveSupport::JSON.decode(page.source).fetch("score")
    
    score.should be_nil
  end
end