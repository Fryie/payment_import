require 'rails_helper'

describe OrdersController do

  describe '#import_payments_form' do
    
    it 'renders the import template' do
      get :import_payments_form
      expect(response).to render_template :import_payments_form
    end

  end

  describe '#import_payments' do

    let(:results) { { successful: 0, unsuccessful: 0 } }
    
    before :each do
      allow(ImportPaymentService).to receive(:import) { results }
    end

    it 'imports the payments' do
      post :import_payments, file: 'FILE'
      expect(ImportPaymentService).to have_received(:import).with 'FILE'
    end

    it 'displays how many payments could be imported' do
      results[:successful] = 5
      post :import_payments, file: 'FILE'
      expect(flash[:notice]).to match '5'
    end

    it 'does not display a success message if no payments imported' do
      results[:successful] = 0
      post :import_payments, file: 'FILE'
      expect(flash[:notice]).to be_nil
    end

    it 'displays how many payments could not be imported' do
      results[:unsuccessful] = 3
      post :import_payments, file: 'FILE'
      expect(flash[:error]).to match '3'
    end

    it 'does not display a failure message if all payments imported' do
      results[:unsuccessful] = 0
      post :import_payments, file: 'FILE'
      expect(flash[:error]).to be_nil
    end

    it 'stores the unsuccessful imports' do
      results[:failed_rows] = 'ROWS'
      post :import_payments, file: 'FILE'
      expect(assigns(:failed_rows)).to eq 'ROWS'
    end

    it 'renders the form' do
      post :import_payments, file: 'FILE'
      expect(response).to render_template :import_payments_form
    end

  end
end
