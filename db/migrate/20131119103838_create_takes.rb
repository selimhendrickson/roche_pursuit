class CreateTakes < ActiveRecord::Migration
  def change
    create_table :takes do |t|
      t.integer :user_id
      t.integer :quiz_id

      t.timestamps
    end
    add_index :takes, :user_id
    add_index :takes, :quiz_id
    add_index :takes, [:user_id, :quiz_id], unique: true
  end
end
