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
- Написан в ОО стиле без "магии". Легко встроится в ваши сервисные объекты и юнит тесты

# Содержание
- [Установка](#установка)
- [Документация](#документация)
- [Примеры использования](#примеры-использования)
  - [Регистрация заказа](#регистрация-заказа)
  - [Замена HTTP клиента](#замена-http-клиента)
  - [Замена JSON парсера](#замена-json-парсера)

## Установка

### RubyGems.org

```sh
% gem install sbrf_merchant
```

### Bundler

```ruby
# Gemfile
gem 'sbrf_merchant'
```
## Документация к API
- [WEB(RU)](https://securepayments.sberbank.ru/wiki/doku.php/integration:api:start)
- [PDF(RU)](http://cs.petrsu.ru/~vadim/sd2018/Merchant-Manual-SBRF.pdf)

## Примеры использования
### Регистрация заказа
```ruby
# Cоздаем клиент
client = SBRF::Api::Client.new(
  user_name: '<Merchant Username>',
  password: '<Merchant Password>',
  host: '<Sberbank API Host>' # например https://3dsec.sberbank.ru
)

# Вызываем метод API.
# :register - название метода согласно документации Cбербанка в snake_case.
# Далее параметры запроса. Имена передаются в snake_case,
# перед отправкой запроса все параметры приведутся к camelCase.

params = {
  amount: 100,
  order_number: "something_unique_string",
  return_url: 'localhost:3000'
}
response = client.call(:register, **params)

response.success? # => true
# В ответе доступ к атрибутам в snake_case
response.order_id #<order-id>

# Пример запроса 'получить информацию о заказе
client.call(:get_order_status, order_id: response.order_id)

```
### Замена HTTP клиента
По умолчанию гем использует ```Net::Http``` для отправки HTTP запросов. Если в вашем проекте используется другой Http клиент, например [Faraday](https://github.com/lostisland/faraday) то нужно реализовать callable класс или Proc и передать его в конструктор:
```ruby
client = SBRF::Api::Client.new(
  user_name: '<Merchant Username>',
  password: '<Merchant Password>',
  host: '<Sberbank API Host>', # например https://3dsec.sberbank.ru',
  http_client: ->(uri, params) { Faraday.post(uri, params) }
)
```

### Замена JSON парсера
По умолчанию гем использует класс```JSON``` для парсинга JSON строк. Если в вашем проекте используется другой парсер, например [Oj](https://github.com/ohler55/oj) то нужно реализовать callable класс или Proc и передать его в конструктор:
```ruby
client = SBRF::Api::Client.new(
  user_name: '<Merchant Username>',
  password: '<Merchant Password>',
  host: '<Sberbank API Host>', # например https://3dsec.sberbank.ru',
  json_parser: ->(json) { Oj.load(json, symbol_keys: true) }
)
```
## Copyright
Copyright (c) 2018-2020 Eugene Kozlov.
