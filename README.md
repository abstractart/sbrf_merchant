# Sberbank Merchant

[![Build Status](https://travis-ci.org/abstractart/sbrf_merchant.svg?branch=master)](https://travis-ci.org/abstractart/sbrf_merchant)
[![Gem Version](https://badge.fury.io/rb/sbrf_merchant.svg)](https://badge.fury.io/rb/sbrf_merchant)
[![Code Climate](https://codeclimate.com/github/abstractart/sbrf_merchant/badges/gpa.svg
)](https://codeclimate.com/github/abstractart/sbrf_merchant)
[![Test Coverage](https://api.codeclimate.com/v1/badges/db86deaba446bac68ae1/test_coverage)](https://codeclimate.com/github/abstractart/sbrf_merchant/test_coverage)
## Installation

### Manually from RubyGems.org ###

```sh
% gem install sbrf_merchant
```

### Or if you are using Bundler ###

```ruby
# Gemfile
gem 'sbrf_merchant'
```

## Configuration

```ruby
SbrfMerchant.configure do |config|
  config.userName = '<Merchant Username>'
  config.password = '<Merchant Password>'
  config.host =     '<Sberbank API Host>'
end
```
## API Documentation
[RU](https://securepayments.sberbank.ru/wiki/doku.php/integration:api:start)

# Usage Examples
```ruby
# First of all you need create order object
new_order = SbrfMerchant::Order::OneStage.new(orderNumber: orderNumber)
already_created_order = SbrfMerchant::Order::OneStage.new(orderNumber: orderNumber, orderId: orderId)
```
## Register Order
```ruby
require 'securerandom'
order = SbrfMerchant::Order::OneStage.new(orderNumber: SecureRandom.hex)
response = order.register(amount: 10000, returnUrl: 'http:/localhost:3000')

order.orderId # returns unique Id in Sberbank system
response.success? # true
response.formUrl # "https://3dsec.sberbank.ru/payment/merchants/sbersafe/payment_ru.html?mdOrder=<orderId>"
```
## Order Status
```ruby
order = SbrfMerchant::Order::OneStage.new(orderNumber: orderNumber, orderId: orderId)
response = order.get_info
response.not_paid? # true or false
```
## Refund
```ruby

refund_amount = 1000
order = SbrfMerchant::Order::OneStage.new(orderNumber: orderNumber, orderId: orderId)
response = order.refund(refund_amount)
response.success? # true or false
```
## Cancel
```ruby

order = SbrfMerchant::Order::OneStage.new(orderNumber: orderNumber, orderId: orderId)
response = order.cancel
response.success? # true or false
  ```
## Supported Ruby Versions (Travis CI)

- 2.5.1
- 2.4.4
- 2.3.7
- 2.2.10

## Copyright
Copyright (c) 2018 Eugene Kozlov. See [LICENSE][] for details.

[license]: LICENSE.md
