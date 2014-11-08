Sequel.migration do
  change do
    create_table(:payments) do
      primary_key :id
      column :transaction_date, "date"
      column :value_date, "date"
      column :reference, "text"
      column :iban, "text"
      column :bic, "text"
    end
    
    create_table(:schema_migrations) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:users) do
      primary_key :id
      column :first_name, "text"
      column :last_name, "text"
    end
    
    create_table(:orders) do
      primary_key :id
      column :number, "integer"
      foreign_key :user_id, :users, :null=>false, :key=>[:id]
      
      index [:number], :unique=>true
    end
    
    create_table(:orders_payments) do
      foreign_key :order_id, :orders, :null=>false, :key=>[:id]
      foreign_key :payment_id, :payments, :key=>[:id]
      
      index [:order_id], :name=>:orders_payments_order_id_key, :unique=>true
      index [:payment_id], :name=>:orders_payments_payment_id_key, :unique=>true
    end
  end
end
Sequel.migration do
  change do
    self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20141108184812_create_users.rb')"
    self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20141108185220_create_orders.rb')"
    self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20141108194520_create_payments.rb')"
  end
end
