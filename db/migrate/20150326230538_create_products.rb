class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :products, :users
    add_index :products, [:user_id, :created_at]
  end
end
