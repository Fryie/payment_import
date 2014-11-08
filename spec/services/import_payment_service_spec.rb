require 'rails_helper'
require 'csv'

describe ImportPaymentService do

  describe '#import' do
    
    let(:order) { Order.create(user: User.create) }
    let(:payment) { Payment.create }

    before :each do
      allow(ImportPaymentService).to receive(:matching_order) { order }
      allow(ImportPaymentService).to receive(:create_payment) { payment }
    end

    it 'creates the payments' do
      allow(CSV).to receive(:read) { [1, 2] }
      ImportPaymentService.import('FILE')
      expect(ImportPaymentService).to have_received(:create_payment).exactly(:twice)
    end

    it 'assigns payments to their matching orders' do
      allow(CSV).to receive(:read) { [1] }
      ImportPaymentService.import('FILE')
      expect(order.payment).to eq payment
    end

    context 'results' do
      let(:results) { ImportPaymentService.import('FILE') }

      before :each do
        allow(ImportPaymentService).to receive(:matching_order) do |row|
          if row == 2
            nil
          else
            Order.create(user: User.create)
          end
        end
        allow(CSV).to receive(:read) { [1, 2, 3] }
      end

      it 'returns the successful matches' do
        expect(results[:successful]).to match_array [1, 3]
      end

      it 'returns the unsuccesful matches' do
        expect(results[:unsuccessful]).to eq [2]
      end
    end

  end

  describe '#create_payment' do

    it 'sets the payment attributes correctly' do
      allow(ImportPaymentService).to receive(:parse_amount) { BigDecimal.new('2.50') }
      row = ["06.11.2014", "06.11.2014", "SEPA-Gutschrift von", "Janek Niete",
             "Kündigung 19459", "DE7625010030018697xxxx", "PBNKDEFFXXX",
             "ZV0100170490436400000002", nil, nil, nil, nil, nil, nil, "2,50",
             "EUR"] 
      payment = ImportPaymentService.send(:create_payment, row)
      expect(payment.transaction_date).to eq Date.new(2014, 11, 6)
      expect(payment.value_date).to eq Date.new(2014, 11, 6)
      expect(payment.reference).to eq "SEPA-Gutschrift von Janek Niete\nKündigung 19459\nZV0100170490436400000002"
      expect(payment.iban).to eq 'DE7625010030018697xxxx'
      expect(payment.bic).to eq 'PBNKDEFFXXX'
      expect(payment.amount).to eq BigDecimal.new('2.50')
      expect(payment.currency).to eq 'EUR'
    end

  end

  describe '#parse_amount' do

    it 'works with a decimal period' do
      expect(ImportPaymentService.send(:parse_amount, '2.50').to_f).to eq 2.5
    end

    it 'works with a decimal comma' do
      expect(ImportPaymentService.send(:parse_amount, '2,50').to_f).to eq 2.5 
    end

  end

end
