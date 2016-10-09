class CreateOperations < ActiveRecord::Migration[5.0]
  def change
    create_table :operations do |t|
      t.integer :op_type, ibdex: true
      t.integer :sum
      t.references :sender, foreign_key: {to_table: :users, on_delete: :nullify}
      t.references :receiver, foreign_key: {to_table: :users, on_delete: :nullify}
      t.timestamp :date, ibdex: true
      t.string :uuid, ibdex: true
      t.boolean :accept, ibdex: true

      t.timestamps
    end
  end
end
