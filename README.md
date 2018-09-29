# Sberbank Merchant
[![Build Status](https://travis-ci.org/abstractart/sbrf_merchant.svg?branch=master)](https://travis-ci.org/abstractart/sbrf_merchant)
Ruby wrapper for the Sberbank Merchant API. [Documentation (RU)](https://securepayments.sberbank.ru/wiki/doku.php/integration:api:start)
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
## Supported Ruby Versions
**WIP** (tested only Ruby 2.5)

## Copyright
Copyright (c) 2018 Eugene Kozlov. See [LICENSE][] for details.

[license]: LICENSE.md
