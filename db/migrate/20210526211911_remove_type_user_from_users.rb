class RemoveTypeUserFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :type_user, :string
  end
end
