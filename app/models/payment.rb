class Payment < Sequel::Model
  many_to_one :order  
end
