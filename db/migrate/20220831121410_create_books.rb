class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.string :genre
      t.references :author, null: false, foreign_key: true
      t.string :puclication_date
      t.string :publishing_company
      t.string :etc

      t.timestamps
    end
  end
end
