class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.integer :movie_id
      t.string :title
      t.integer :movie_popularity

      t.timestamps
    end
  end
end
