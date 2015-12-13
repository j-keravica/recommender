class AddIndexToMovies < ActiveRecord::Migration
  def change
    add_index :movies, :movie_id, unique: true
  end
end
