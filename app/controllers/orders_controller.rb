class OrdersController < ApplicationController

  def import_payments_form
  end

  def import_payments
    results = ImportPaymentService.import(file)
    if results[:successful].size > 0
      flash.now[:notice] = "#{results[:successful].size} payments imported"
    end
    if results[:unsuccessful].size > 0
      flash.now[:error] = "Failed to import #{results[:unsuccessful].size} payments"
    end

    @failed_rows = results[:unsuccessful]
    render :import_payments_form
  end

  private

  def file
    params[:file].path
  end

end
