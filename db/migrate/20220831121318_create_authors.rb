class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :genre_predominant
      t.string :years_old
      t.string :etc

      t.timestamps
    end
  end
end
