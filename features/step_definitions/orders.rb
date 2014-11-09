Given /^there are some orders$/ do
  # create users
  @karl = User.create(first_name: 'Karl', last_name: 'Rot')
  @andrea = User.create(first_name: 'Andrea', last_name: 'Ballermann')
  @dagmar = User.create(first_name: 'Dagmar', last_name: 'Vettel')

  # create orders
  @karl.add_order number: 19956
  @andrea.add_order number: 20426
  @dagmar.add_order number: 19438
  @dagmar.add_order number: 19436
end

When /^I import the payment data$/ do
  visit root_path
  attach_file 'Payment File', Rails.root.join('features', 'fixtures', 'payments.csv')
  click_button 'Upload'
end

Then /^the payments should be associated with the orders$/ do
  expect(@karl.orders.first.payment.iban).to eq 'DE835535001000032xxxx'
  expect(@andrea.orders.first.payment.iban).to eq 'DE6976391000000690xxxx'
  expect(
    @dagmar.orders.map do |order|
      order.payment.iban
    end
  ).to match_array ['DE1270070024035233xxxx', 'DE127007002403523xxxx']
end

Then /^I should see the payments that could not be associated$/ do
  expect(find('table')).to have_content 'Krause, Uwe'
  expect(find('table')).to have_content 'Janek Niete'
end
