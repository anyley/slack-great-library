class CreateItemsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :items_users do |t|
      t.belongs_to :item, foreign_key: {on_delete: :cascade}
      t.belongs_to :user, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
