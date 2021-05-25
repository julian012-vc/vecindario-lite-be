class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :fist_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :type_user
      t.string :password
    end
  end
end
