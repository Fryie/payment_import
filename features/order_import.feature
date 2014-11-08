Feature: Payment Import

  As an account manager
  I want to import payment data
  So I can associate the payments with their orders

  Scenario: Import payments
    Given there are some orders
    When I import the payment data
    Then the payments should be associated with the orders
    And I should see the payments that could not be associated
