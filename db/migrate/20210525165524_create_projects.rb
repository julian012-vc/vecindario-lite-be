class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title,          null: false
      t.string :type_project,   null: false
      t.string :city,           null: false
      t.string :address,        null: false
      t.integer :price,         null: false
      t.integer :private_area,  null: false
      t.integer :building_area, null: false
      t.boolean :has_vis,       null: false
      t.boolean :has_parking,   null: false
      t.integer :bathrooms,     null: true
      t.string :email,          null: false

      t.belongs_to :user,       null: false, foreign_key: true

      t.timestamps
    end
  end
end
