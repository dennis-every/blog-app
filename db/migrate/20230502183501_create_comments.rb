class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :author_id
      t.references :post, null: false, foreign_key: true
      t.text :text

      t.timestamps
    end
    add_index :comments, :author_id
  end
end
