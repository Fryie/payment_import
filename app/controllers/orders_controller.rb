class OrdersController < ApplicationController

  def import_payments_form
  end

  def import_payments
    results = ImportPaymentService.import(params[:file])
    if results[:successful] > 0
      flash[:notice] = "#{results[:successful]} payments imported"
    end
    if results[:unsuccessful] > 0
      flash[:error] = "Failed to import #{results[:unsuccessful]} payments"
    end

    @failed_rows = results[:failed_rows]
    render :import_payments_form
  end

end
