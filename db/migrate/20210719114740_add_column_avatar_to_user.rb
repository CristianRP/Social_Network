class AddColumnAvatarToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :avatar, :binary
  end
end
