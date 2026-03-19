class CreateArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.text :summary
      t.datetime :published_at
      t.string :slug

      t.timestamps
    end
    add_index :articles, :slug, unique: true
  end
end
