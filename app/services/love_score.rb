class LoveScore
  NoScore = Class.new

  def self.for_term(term)
    positive = SearchEngine.count_results("i love #{term}").to_f
    negative = SearchEngine.count_results("i hate #{term}").to_f
    score = 10 * positive / (positive + negative)
    score.nan? ? NoScore : score
  end
end