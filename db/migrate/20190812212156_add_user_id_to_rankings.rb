class AddUserIdToRankings < ActiveRecord::Migration[5.2]
  def change
    add_column :rankings, :user_id, :integer
    add_reference :rankings, :user, foreign_key: true
  end
end
