require 'rails_helper'

describe OrdersController do

  describe '#import_payments_form' do
    
    it 'renders the import template' do
      get :import_payments_form
      expect(response).to render_template :import_payments_form
    end

  end

end
