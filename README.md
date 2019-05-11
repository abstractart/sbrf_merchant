# Sberbank Merchant

[![Build Status](https://travis-ci.org/abstractart/sbrf_merchant.svg?branch=master)](https://travis-ci.org/abstractart/sbrf_merchant)
[![Gem Version](https://badge.fury.io/rb/sbrf_merchant.svg)](https://badge.fury.io/rb/sbrf_merchant)
[![Code Climate](https://codeclimate.com/github/abstractart/sbrf_merchant/badges/gpa.svg
)](https://codeclimate.com/github/abstractart/sbrf_merchant)
[![Test Coverage](https://api.codeclimate.com/v1/badges/db86deaba446bac68ae1/test_coverage)](https://codeclimate.com/github/abstractart/sbrf_merchant/test_coverage)

Ruby клиент для работы с платёжным шлюзом Сбербанка.

Ключевые особенности:
- Простой (~200 LOC).
- Расширяемый из коробки. Если В API появится новый метод то данный клиент будет его поддерживать без каких либо правок в исходный код
- Написан в ОО + ФП стиле без "магии". Легко встроится в ваши сервисные объекты и юнит тесты

## Установка

### RubyGems.org ###

```sh
% gem install sbrf_merchant
```

### Bundler ###

```ruby
# Gemfile
gem 'sbrf_merchant', '~> 2.0.0`
```
## Документация
- [Site(RU)](https://securepayments.sberbank.ru/wiki/doku.php/integration:api:start)
- [PDF(RU)](http://cs.petrsu.ru/~vadim/sd2018/Merchant-Manual-SBRF.pdf)

## Использование
### Пример регистрации заказа
```ruby
# Перед использованием необходимо проинициализировать библиотеку.
SbrfMerchant.configure do |config|
  config.user_name = '<Merchant Username>'
  config.password = '<Merchant Password>'
  config.host =     '<Sberbank API Host>'
end

# или

SbrfMerchant.configuration = SbrfMerchant::Configuration.new(
  host: '<Sberbank API Host>',
  user_name: '<Merchant Username>',
  password: '<Merchant Password>'
)


# Cоздаем клиент
client = SbrfMerchant::Api::Client.new

# Вызываем метод API.
# :register - название метода согласно документации Cбербанка в snake_case.
# Далее параметры запроса. Имена передаются в snake_case, перед отправкой запроса все параметры приведутся к camelCase.
response = client.call(:register, amount: 100, order_number: SecureRandom.hex, return_url: 'localhost:3000')
response.success? # => true
# В ответе имена возвращаются в snake_case
response.order_id #<order-id>

```
## Copyright
Copyright (c) 2018 Eugene Kozlov. See [LICENSE][] for details.

[license]: LICENSE.md
