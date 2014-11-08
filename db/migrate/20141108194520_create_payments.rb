Sequel.migration do 
  change do

    create_table :payments do
      primary_key :id
      Date :transaction_date
      Date :value_date
      Text :reference
      String :iban
      String :bic
    end

    create_table :orders_payments do
      foreign_key :order_id, :orders, unique: true, null: false
      foreign_key :payment_id, :payments, unique: true
    end

  end
end
