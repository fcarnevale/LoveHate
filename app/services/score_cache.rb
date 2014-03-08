class ScoreCache
  def self.for_term(term)
    CachedScore.for_term(term)
  rescue CachedScore::NoScore
    score = LoveScore.for_term(term)
    CachedScore.save_score(term, score)
    score
  end
end