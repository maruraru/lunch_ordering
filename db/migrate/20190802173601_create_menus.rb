class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.date :date, null: false

      t.timestamps
    end

    add_index :menus, :date, unique: true
  end
end
