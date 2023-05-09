class FetchDolarDataJob < ApplicationJob
  queue_as :default

  def perform
    # Put the code to call the fetch_data action in the DolarController
    DolarController.new.fetch_exchange_rates
  end
end
