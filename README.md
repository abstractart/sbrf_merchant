# Sberbank Merchant

[![Build Status](https://travis-ci.org/abstractart/sbrf_merchant.svg?branch=master)](https://travis-ci.org/abstractart/sbrf_merchant)
[![Gem Version](https://badge.fury.io/rb/sbrf_merchant.svg)](https://badge.fury.io/rb/sbrf_merchant)
[![Code Climate](https://codeclimate.com/github/abstractart/sbrf_merchant/badges/gpa.svg
)](https://codeclimate.com/github/abstractart/sbrf_merchant)
[![Test Coverage](https://api.codeclimate.com/v1/badges/db86deaba446bac68ae1/test_coverage)](https://codeclimate.com/github/abstractart/sbrf_merchant/test_coverage)

Ruby клиент для работы с платёжным шлюзом Сбербанка.

Ключевые особенности:
- Простой (~200 LOC).
- Лёгкий (всего одна зависимость - JSON gem).
- Написан в ОО стиле без "магии". Подходит для написания unit тестов.

## Установка

### RubyGems.org ###

```sh
% gem install sbrf_merchant
```

### Bundler ###

```ruby
# Gemfile
gem 'sbrf_merchant'
```

## Конфигурация
Перед использованием необходимо проинициализировать библиотеку
```ruby
SbrfMerchant.configure do |config|
  config.userName = '<Merchant Username>'
  config.password = '<Merchant Password>'
  config.host =     '<Sberbank API Host>'
end
```
## Документация
- [Site(RU)](https://securepayments.sberbank.ru/wiki/doku.php/integration:api:start)
- [PDF(RU)](http://cs.petrsu.ru/~vadim/sd2018/Merchant-Manual-SBRF.pdf)
## Использование
### Терминология

- **orderId** - ID заказа в Сбербанке
- **orderNumber** - ID заказа в Вашей системе

### Инициализация объекта заказа
Если необходимо зарегистрировать новый заказ
```ruby
SbrfMerchant::Order.new(orderNumber: orderNumber)
```
Если необходимо поработать с уже существующим
```ruby
SbrfMerchant::Order.new(orderNumber: orderNumber, orderId: orderId)
```
### Аргументы вызываемых методов
- передаются через keywords
- имена аргументов такие же как и в документации
### Ответы API
Ответы API возвращаются как объекты. Доступ через reader(getter) методы. Также в классах есть методы упрощающие работу с телом ответа (проверка успешности запроса, определение статуса заказа)
### Примеры работы
#### Регистрация заказа
```ruby
require 'securerandom'
order = SbrfMerchant::Order.new(orderNumber: SecureRandom.hex)
response = order.register_one_stage(amount: 10000, returnUrl: 'http:/localhost:3000')

order.orderId # "<orderId>"
response.success? # true
response.formUrl # "https://3dsec.sberbank.ru/payment/merchants/sbersafe/payment_ru.html?mdOrder=<orderId>"
```
Для создания двустадийного заказа используте метод ```register_two_stage```
#### Статус заказа
```ruby
response = order.get_info
response.not_paid? # true or false
```
#### Возврат средств
```ruby
refund_amount = 1000
response = order.refund(refund_amount)
response.success? # true or false
```
#### Отмена заказа
```ruby
response = order.cancel
response.success? # true or false
```
#### Завершение заказа (двухстадийная оплата)
```ruby
complete_amount = 1000
response = order.complete(complete_amount)
response.success? # true or false
```
## Copyright
Copyright (c) 2018 Eugene Kozlov. See [LICENSE][] for details.

[license]: LICENSE.md
