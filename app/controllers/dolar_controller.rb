class DolarController < ApplicationController
  require 'httparty'

  def fetch_exchange_rates
    api_url = 'https://www.dolarsi.com/api/api.php?type=valoresprincipales' # Replace with your API URL

    response = HTTParty.get(api_url)
    if response.code == 200
      dolar_rates = JSON.parse(response.body)

      dolar_rates.each do |rate|
        dolar = Dolar.find_or_initialize_by(name: rate['casa']['nombre'])

        compra = BigDecimal(string_to_decimal(rate['casa']['compra']))
        venta = BigDecimal(string_to_decimal(rate['casa']['venta']))

        # Save the current values to the DolarHistory
        dolar.dolar_histories.create(compra: compra, venta: venta)

        dolar.update!(
          name: rate['casa']['nombre'],
          description: rate['casa']['nombre'],
          compra: compra,
          venta: venta
        )
      end

      print 'Products fetched and saved successfully.'
    else
      print 'There was an error fetching the products.'
    end
  end

  def history
    @dolars = Dolar.all
    @selected_dolar = Dolar.find(params[:dolar_id]) if params[:dolar_id].present?
    @dolar_histories = @selected_dolar.dolar_histories.order(created_at: :desc) if @selected_dolar.present?
    render json: @dolar_histories, include: { dolar: { only: :name } }
  end

  def string_to_decimal(string_value)
    normalized_string = string_value.gsub(',', '.')
    decimal_value = normalized_string.to_d
    decimal_value
  end

  def index
    @dolars = Dolar.all
    render json: @dolars
  end

  def show
    @dolars = Dolar.find(params[:nombre])
  end

  # Add any other actions you might need.
end
