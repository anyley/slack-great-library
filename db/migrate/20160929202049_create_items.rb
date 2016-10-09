class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :description, index: true
      t.string :url
      t.integer :price
      t.string :valute
      t.string :itemtype, index: true
      t.references :offered_by, foreign_key: {to_table: 'users', on_delete: :nullify}

      t.string :filename
      t.string :mime_type
      t.binary :data

      t.timestamps
    end
  end
end
