class AddIndexRelationshipUserId < ActiveRecord::Migration[5.2]
  def change
    add_index :relationships, :user_id
    add_index :relationships, :follow_id
    add_index :relationships, [:user_id,:follow_id],unique: true
  end
end
