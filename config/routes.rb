Rails.application.routes.draw do
  root to: 'orders#import_payments_form'
  post '/import' => 'orders#import_payments'
end
