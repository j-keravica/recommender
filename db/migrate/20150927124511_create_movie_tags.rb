class CreateMovieTags < ActiveRecord::Migration
  def change
    create_table :movie_tags do |t|
    	  t.belongs_to :movie, index: true
      	t.belongs_to :tag, index: true
      	t.decimal :relevance
    end
  end
end
