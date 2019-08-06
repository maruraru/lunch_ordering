class CreateMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items do |t|
      t.string :name, null: false
      t.string :category, null: false
      t.float :price, null: false
      t.string :photo
      t.references :menu

      t.timestamps
    end

    add_index :menu_items, :name
  end
end
