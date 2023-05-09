class CreateDolars < ActiveRecord::Migration[7.0]
  def change
    create_table :dolars do |t|
      t.string :name
      t.text :description
      t.decimal :compra
      t.decimal :venta

      t.timestamps
    end
  end
end
