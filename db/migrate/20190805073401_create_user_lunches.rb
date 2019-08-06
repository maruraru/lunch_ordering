class CreateUserLunches < ActiveRecord::Migration[5.2]
  def change
    create_table :user_lunches do |t|
      t.belongs_to :user, null: false
      t.belongs_to :first_dish, null: false
      t.belongs_to :main_dish, null: false
      t.belongs_to :drink, null: false

      t.timestamps
    end
  end
end
