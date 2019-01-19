RSpec.shared_context 'API Client Register One Stage Order Stub' do
  let(:order_id) { 'orderId' }
  let(:amount) { 1000 }
  let(:form_url) { 'formUrl' }
  let(:return_url) { 'returnUrl' }

  let(:api_client) do
    api_client = instance_double(SbrfMerchant::Api::Client)
    allow(api_client).to receive(:process_request).with(SbrfMerchant::Api::Action::REGISTER_ORDER, amount: amount, returnUrl: return_url, orderNumber: order_number)
                                                  .and_return(orderId: order_id, formUrl: form_url)

    api_client
  end
end

RSpec.shared_context 'API Client Register Two Stage Order Stub' do
  let(:order_id) { 'orderId' }
  let(:amount) { 1000 }
  let(:form_url) { 'formUrl' }
  let(:return_url) { 'returnUrl' }

  let(:api_client) do
    api_client = instance_double(SbrfMerchant::Api::Client)
    allow(api_client).to receive(:process_request).with(SbrfMerchant::Api::Action::REGISTER_PRE_AUTH, amount: amount, returnUrl: return_url, orderNumber: order_number)
                                                  .and_return(orderId: order_id, formUrl: form_url)

    api_client
  end
end

RSpec.shared_context 'API Client Refund Order Stub' do
  let(:order_id) { 'orderId' }
  let(:amount) { 1000 }
  let(:error_code) { '0' }
  let(:error_message) { '' }

  let(:api_client) do
    api_client = instance_double(SbrfMerchant::Api::Client)
    allow(api_client).to receive(:process_request).with(SbrfMerchant::Api::Action::REFUND_ORDER, amount: amount, orderNumber: order_number, orderId: order_id)
                                                  .and_return(error_code: error_code, error_message: error_message)

    api_client
  end
end

RSpec.shared_context 'API Client Order Status Stub' do
  let(:order_id) { 'orderId' }
  let(:order_status) { SbrfMerchant::Api::OrderStatus::NOT_PAID }
  let(:amount) { 1000 }
  let(:error_code) { '0' }
  let(:error_message) { '' }
  let(:api_response) do
    {
      errorCode: error_code,
      errorMessage: error_message,
      orderNumber: order_number,
      orderStatus: order_status,
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
      bankInfo: { bankName: 'TEST CARD', bankCountryCode: 'RU', bankCountryName: 'Россия' }
    }
  end
  let(:api_client) do
    api_client = instance_double(SbrfMerchant::Api::Client)
    allow(api_client).to receive(:process_request).with(SbrfMerchant::Api::Action::ORDER_STATUS, orderNumber: order_number, orderId: order_id)
                                                  .and_return(api_response)

    api_client
  end
end

RSpec.shared_context 'API Client Order Cancel Stub' do
  let(:order_id) { 'orderId' }
  let(:error_code) { '0' }
  let(:error_message) { '' }

  let(:api_client) do
    api_client = instance_double(SbrfMerchant::Api::Client)
    allow(api_client).to receive(:process_request).with(SbrfMerchant::Action::CANCEL_ORDER, orderNumber: order_number, orderId: order_id)
                                                  .and_return(error_code: error_code, error_message: error_message)

    api_client
  end
end

RSpec.shared_context 'API Client Complete Order Stub' do
  let(:order_id) { 'orderId' }
  let(:error_code) { '0' }
  let(:error_message) { '' }
  let(:amount) { 1000 }

  let(:api_client) do
    api_client = instance_double(SbrfMerchant::Api::Client)
    allow(api_client).to receive(:process_request).with(SbrfMerchant::Api::Action::COMPLETE_ORDER, amount: amount, orderNumber: order_number, orderId: order_id)
                                                  .and_return(errorCode: error_code, errorMessage: error_message)

    api_client
  end
end
