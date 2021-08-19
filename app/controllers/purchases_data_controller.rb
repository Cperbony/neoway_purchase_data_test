class PurchasesDataController < ApplicationController
  before_action :process_all_data, :load_data, only: %i[index]

  def index
    @data_purchases = @data_purchases.order(created_at: :desc).page(params[:page])
    @data_purchases.map(&:to_app)

    # Used to render infos json
    # render json: { data: @data.map(&:to_app) }
  end

  private

  # When index load, process_data is called throught rails before_action to load new data inserted in 'base_teste.txt'
  def process_all_data
    PurchaseData.new.process_data
  end

  def load_data
    @data_purchases = PurchaseData.where.not(cpf: nil).all
  end

  def permitted_params
    params.permit(%i[page])
  end
end
