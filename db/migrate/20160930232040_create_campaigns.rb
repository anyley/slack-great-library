class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.string :uuid, ibdex: true
      t.references :item, foreign_key: {to_table: :items, on_delete: :nullify}
      t.references :initiator, foreign_key: {to_table: :users, on_delete: :nullify}
      t.integer :status, ibdex: true

      t.timestamps
    end
  end
end
