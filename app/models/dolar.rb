class Dolar < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: false
  validates :compra, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :venta, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :dolar_histories, dependent: :destroy
  # Add any other validations or associations you might need.
end
