class PurchasesDataController < ApplicationController
  def index
    @data = PurchaseData.all

    render json: {
      data: @data.map(&:to_app),
    }
  end
end
