class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :text
      t.integer :commentscounter
      t.integer :likescounter
      t.integer :author, class_name: "user"
      t.integer :author_id

      t.timestamps
    end
  end
end
