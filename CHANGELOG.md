# Changelog 3.0.0
- Drop configure from SbrfMerchant, move params to SBRF::Api::Client#initialize
- Update minimum Ruby version to 2.3
# Changelog 2.0.1
- Nested fields of API response is OpenStruct, not Hash
# Changelog 2.0.0
- Drop SbrfMerchant::Order
- Rewrite SbrfMerchant::Api::Client, now it extendable by default for every request in API
- Add converting API request body from snake_case to camelCase
- Add converting API response body from camelCase to snake_case
# Changelog 1.0.0
- Replace Order::OneStage class with Order class
- Add methods for working with two stage orders
# Changelog 0.2.0
- Replace external gems with Ruby standard library features
# Changelog 0.1.3
- Fix unexpected behaviour in Response::Base#success?

# Changelog 0.1.2
- Fix errors in Response::OrderStatus

# Changelog 0.1.1
- Add support of OneStage Order (register, cancel, refund, status)
