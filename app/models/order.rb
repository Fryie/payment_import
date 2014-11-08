class Order < Sequel::Model
  many_to_one :user  
  one_through_one :payment
end
