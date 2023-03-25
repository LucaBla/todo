class AddCreatorIdToFriendships < ActiveRecord::Migration[7.0]
  def change
    add_column :friendships, :creator_id, :integer
  end
end
