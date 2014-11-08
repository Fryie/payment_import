Sequel.migration do
  change do
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
  end
end
Sequel.migration do
  change do
    self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20141108184812_create_users.rb')"
    self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20141108185220_create_orders.rb')"
  end
end
