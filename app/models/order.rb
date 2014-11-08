class Order < Sequel::Model
  many_to_one :user  
  one_to_one :payment
end
