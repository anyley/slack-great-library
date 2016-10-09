class CreateCampaignUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns_users do |t|
      t.references :campaign, foreign_key: {on_delete: :cascade}
      t.references :user, foreign_key:  {on_delete: :cascade}

      t.timestamps
    end

    add_index :campaigns_users, [:campaign_id, :user_id], unique: true
  end
end
