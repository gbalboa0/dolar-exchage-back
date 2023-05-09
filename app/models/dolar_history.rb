class DolarHistory < ApplicationRecord
  belongs_to :dolar

  validates :compra, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :venta, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
