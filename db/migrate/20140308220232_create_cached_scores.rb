class CreateCachedScores < ActiveRecord::Migration
  def change
    create_table :cached_scores do |t|
      t.string :term
      t.float :score
    end
  end
end
