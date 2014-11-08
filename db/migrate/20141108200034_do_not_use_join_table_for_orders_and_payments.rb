Sequel.migration do
  change do
    drop_table :orders_payments

    alter_table :payments do
      add_foreign_key :order_id, :orders, unique: true
    end
  end
end
