class AddAvgRatingToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :avg_rating, :decimal, :precision => 5, :scale => 2, :default => -1, :null => false
  end
end
