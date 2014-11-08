When /^I import the payment data$/ do
  visit root_path
  attach_file 'Payment File', Rails.root.join('features', 'fixtures', 'payments.csv')
  click_button 'Upload'
end
