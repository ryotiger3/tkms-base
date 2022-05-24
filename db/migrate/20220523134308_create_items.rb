class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :admin,               foreign_key: true
      t.string     :name,                null: false
      t.integer    :price,               null: false
      t.text       :description,         null: false
      t.integer    :category_id,         null: false
      t.integer    :shipping_days_id,    null: false
      t.references :user,                foreign_key: true

      t.timestamps
    end
  end
end