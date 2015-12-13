class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :tag_id
      t.string :name
      t.integer :tag_popularity

      t.timestamps
    end
  end
end
