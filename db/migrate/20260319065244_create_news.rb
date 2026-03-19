class CreateNews < ActiveRecord::Migration[8.1]
  def change
    create_table :news do |t|
      t.string :title
      t.text :body
      t.text :summary
      t.datetime :published_at
      t.string :category
      t.string :slug

      t.timestamps
    end
    add_index :news, :slug, unique: true
  end
end
