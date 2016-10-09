class CreateClaims < ActiveRecord::Migration[5.0]
  def change
    create_table :claims do |t|
      t.belongs_to :user, foreign_key: {on_delete: :cascade}
      t.belongs_to :item, foreign_key: {on_delete: :cascade}

      t.timestamps
    end

    add_index :claims, [:item_id, :user_id], unique: true
  end
end
