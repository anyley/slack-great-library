class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.belongs_to :operation, foreign_key: {on_delete: :nullify}
      t.belongs_to :campaign, foreign_key: {on_delete: :nullify}
      t.belongs_to :item, foreign_key:  {on_delete: :cascade}
      t.belongs_to :user, foreign_key:  {on_delete: :cascade}
      t.timestamps
    end

    add_index :purchases, [:item_id, :user_id], unique: true
  end
end
