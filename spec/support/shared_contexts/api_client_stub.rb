RSpec.shared_context 'API Client Register One Stage Order Stub' do
  let(:orderId) { 'orderId' }
  let(:amount) { 1000 }
  let(:formUrl) { 'formUrl' }
  let(:returnUrl) { 'returnUrl' }

  let(:api_client) do
    api_client = instance_double(SbrfMerchant::Api::Client)
    allow(api_client).to receive(:process_request).with(SbrfMerchant::Api::Action::REGISTER_ORDER, amount: amount, returnUrl: returnUrl, orderNumber: orderNumber)
                                                  .and_return(orderId: orderId, formUrl: formUrl)

    api_client
  end
end

RSpec.shared_context 'API Client Register Two Stage Order Stub' do
  let(:orderId) { 'orderId' }
  let(:amount) { 1000 }
  let(:formUrl) { 'formUrl' }
  let(:returnUrl) { 'returnUrl' }

  let(:api_client) do
    api_client = instance_double(SbrfMerchant::Api::Client)
    allow(api_client).to receive(:process_request).with(SbrfMerchant::Api::Action::REGISTER_PRE_AUTH, amount: amount, returnUrl: returnUrl, orderNumber: orderNumber)
                                                  .and_return(orderId: orderId, formUrl: formUrl)

    api_client
  end
end

RSpec.shared_context 'API Client Refund Order Stub' do
  let(:orderId) { 'orderId' }
  let(:amount) { 1000 }
  let(:errorCode) { "0" }
  let(:errorMessage) { '' }

  let(:api_client) do
    api_client = instance_double(SbrfMerchant::Api::Client)
    allow(api_client).to receive(:process_request).with(SbrfMerchant::Api::Action::REFUND_ORDER, amount: amount, orderNumber: orderNumber, orderId: orderId)
                                                  .and_return(errorCode: errorCode, errorMessage: errorMessage)

    api_client
  end
end

RSpec.shared_context 'API Client Order Status Stub' do
  let(:orderId) { 'orderId' }
  let(:orderStatus) { SbrfMerchant::Api::OrderStatus::NOT_PAID }
  let(:amount) { 1000 }
  let(:errorCode) { "0" }
  let(:errorMessage) { '' }
  let(:api_response) do
    {
      errorCode: errorCode,
      errorMessage: errorMessage,
      orderNumber: orderNumber,
      orderStatus: orderStatus,
      actionCode: 0,
      actionCodeDescription: '',
      amount: amount,
      currency: '643',
      date: 1_538_233_213_914,
      ip: '83.220.238.250',
      merchantOrderParams: [],
      attributes: [{ name: 'mdOrder', value: '6297fda8-3b15-7413-6297-fda804b030a3' }],
      cardAuthInfo: { expiration: '201912', cardholderName: 'CARDHOLDER NAME', approvalCode: '123456', pan: '411111XXXXXX1111' },
      authDateTime: 1_538_233_277_742,
      terminalId: '12345678',
      authRefNum: '111111111111',
      paymentAmountInfo: { paymentState: 'REFUNDED', approvedAmount: 1000, depositedAmount: 500, refundedAmount: 500 },
      bankInfo: { bankName: 'TEST CARD', bankCountryCode: 'RU', bankCountryName: 'Россия' } }
  end
  let(:api_client) do
    api_client = instance_double(SbrfMerchant::Api::Client)
    allow(api_client).to receive(:process_request).with(SbrfMerchant::Api::Action::ORDER_STATUS, orderNumber: orderNumber, orderId: orderId)
                                                  .and_return(api_response)

    api_client
  end
end

RSpec.shared_context 'API Client Order Cancel Stub' do
  let(:orderId) { 'orderId' }
  let(:errorCode) { "0" }
  let(:errorMessage) { '' }

  let(:api_client) do
    api_client = instance_double(SbrfMerchant::Api::Client)
    allow(api_client).to receive(:process_request).with(SbrfMerchant::Action::CANCEL_ORDER, orderNumber: orderNumber, orderId: orderId)
                                                  .and_return(errorCode: errorCode, errorMessage: errorMessage)

    api_client
  end
end

RSpec.shared_context 'API Client Complete Order Stub' do
  let(:orderId) { 'orderId' }
  let(:errorCode) { "0" }
  let(:errorMessage) { '' }
  let(:amount) { 1000 }

  let(:api_client) do
    api_client = instance_double(SbrfMerchant::Api::Client)
    allow(api_client).to receive(:process_request).with(SbrfMerchant::Api::Action::COMPLETE_ORDER, amount: amount, orderNumber: orderNumber, orderId: orderId)
                                                  .and_return(errorCode: errorCode, errorMessage: errorMessage)

    api_client
  end
end
