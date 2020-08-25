class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      # t.references :user, foreign_key: true
      # t.references :follow, foreign_key: { to_table: :users }

      # t.timestamps

      # t.index [:user_id, :follow_id], unique: true

      # t.timestamps
      t.integer :follower_id
      t.integer :following_id

      t.timestamps null: false
    end

    add_index :relationships, :follower_id
    add_index :relationships, :following_id
    add_index :relationships, [:follower_id, :following_id], unique: true
   end
end
