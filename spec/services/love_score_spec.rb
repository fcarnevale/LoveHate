require_relative "../../app/services/love_score"
require_relative "../../app/services/search_engine"

describe LoveScore do
  it "returns 0 for unpopular terms" do
    allow(SearchEngine).to receive(:count_results).with(%{"i love apple"}).and_return(0)
    allow(SearchEngine).to receive(:count_results).with(%{"i hate apple"}).and_return(1)
    LoveScore.for_term("apple").should eq 0.0
  end

  it "returns 10 for popular terms" do
    allow(SearchEngine).to receive(:count_results).with(%{"i love apple"}).and_return(1)
    allow(SearchEngine).to receive(:count_results).with(%{"i hate apple"}).and_return(0)
    LoveScore.for_term("apple").should eq 10.0
  end

  it "returns mediocre results for mediocre terms" do
    allow(SearchEngine).to receive(:count_results).with(%{"i love apple"}).and_return(9)
    allow(SearchEngine).to receive(:count_results).with(%{"i hate apple"}).and_return(11)
    LoveScore.for_term("apple").should eq 4.5
  end

  it "does not divide by zero" do
    allow(SearchEngine).to receive(:count_results).with(%{"i love apple"}).and_return(0)
    allow(SearchEngine).to receive(:count_results).with(%{"i hate apple"}).and_return(0)
    LoveScore.for_term("apple").should eq LoveScore::NoScore
  end
end