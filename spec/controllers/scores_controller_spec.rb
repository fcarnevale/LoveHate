require "spec_helper"

describe ScoresController do
  it "return scores for terms" do
    allow(ScoreCache).to receive(:for_term).with("microsoft").and_return(8.5)
    get :show, term: "microsoft"
    response.body.should == { term: "microsoft", score: 8.5 }.to_json
  end

  it "return nil for NoScore" do
    allow(ScoreCache).to receive(:for_term).with("microsoft").and_return(LoveScore::NoScore)
    get :show, term: "microsoft"
    response.body.should == { term: "microsoft", score: nil }.to_json
  end
end