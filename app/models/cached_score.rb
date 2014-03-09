class CachedScore < ActiveRecord::Base
  class NoScore < RuntimeError
  end

  def self.save_score(term, score)
    score = nil if score == LoveScore::NoScore
    create!(term: term, score: score)
  end

  def self.for_term(term)
    cached_score = find_by(term: term) or raise NoScore
    score = cached_score.score
    score.nil? ? LoveScore::NoScore : score
  end
end