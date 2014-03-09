class ScoresController < ApplicationController

  def show
    term = params[:term]
    score = ScoreCache.for_term(term)
    score = nil if score == LoveScore::NoScore
    render json: { term: term, score: score }
  end

  def latest
    @latest_terms = CachedScore.last(5).reverse
    render json: @latest_terms
  end
end