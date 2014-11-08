Sequel.migration do 
  change do

    create_table :orders do
      primary_key :id
      Integer :number
      index :number, unique: true, null: false
      foreign_key :user_id, :users, null: false
    end

  end
end
