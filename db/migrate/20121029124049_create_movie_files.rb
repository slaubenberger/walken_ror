class CreateMovieFiles < ActiveRecord::Migration
  def change
    create_table :movie_files do |t|
      t.integer :movie_id
      t.integer :user_id
      t.string :path
      t.string :description

      t.timestamps
    end
  end
end
