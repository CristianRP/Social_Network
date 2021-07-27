class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.string :picture
      t.string :heading
      t.timestamps
    end
  end
end
