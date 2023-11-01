class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :text
      t.integer :commentscounter
      t.integer :likescounter
      t.references :author, foreign_key: { to_table: 'users' }
      t.integer :author_id

      t.timestamps
    end
  end
end
