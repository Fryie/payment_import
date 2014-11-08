Sequel.migration do
  change do
    alter_table :payments do
      set_column_type :amount, 'numeric(10,2)'
    end
  end
end
