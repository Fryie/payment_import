Sequel.migration do
  change do
    alter_table :payments do
      add_column :amount, :money
      add_column :currency, String
    end
  end
end
