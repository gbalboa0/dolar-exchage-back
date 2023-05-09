class CreateDolarHistory < ActiveRecord::Migration[7.0]
  def change
    create_table :dolar_histories do |t|
      t.decimal :compra, precision: 15, scale: 2
      t.decimal :venta, precision: 15, scale: 2
      t.references :dolar, foreign_key: true
      t.timestamps
    end
  end
end
