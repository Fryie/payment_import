Given /^there are some orders$/ do
  # create users
  @karl = User.create(first_name: 'Karl', last_name: 'Rot')
  @uwe = User.create(first_name: 'Uwe', last_name: 'Krause')
  @andrea = User.create(first_name: 'Andrea', last_name: 'Ballermann')
  @dagmar = User.create(first_name: 'Dagmar', last_name: 'Vettel')

  # create orders
  @karl.add_order number: 19956
  @uwe.add_order number: 18858
  @andrea.add_order number: 20426
  @dagmar.add_order number: 19438
end
