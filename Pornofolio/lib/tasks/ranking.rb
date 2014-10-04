class Tasks::Ranking
  def self.tally
    PostAnalysis.tally_ranking
  end
end