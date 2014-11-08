class Payment < Sequel::Model
  one_through_one :order  
end
