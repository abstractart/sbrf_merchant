RSpec.describe SbrfMerchant::Order do
  let(:order_number) { 'order_number' }

  context '#register' do
    include_context 'API Client Register One Stage Order Stub'

    let(:payment) do
      described_class.new(
        order_number: order_number,
        api_client: api_client
      )
    end
    let(:actual_response) do
      payment.register(
        amount: amount,
        return_url: return_url
      )
    end

    it 'returns order_id & payment formURL' do
      expect(actual_response).to be_success
      expect(actual_response.order_id).to eq(order_id)
      expect(actual_response.form_url).to eq(form_url)
      expect(payment.order_id).to eq(order_id)
    end
  end

  context '#register_pre_auth' do
    include_context 'API Client Register Two Stage Order Stub'

    let(:payment) do
      described_class.new(
        order_number: order_number,
        api_client: api_client
      )
    end
    let(:actual_response) do
      payment.register_pre_auth(
        amount: amount,
        returnUrl: return_url
      )
    end

    it 'returns order_id & payment formURL' do
      expect(actual_response).to be_success
      expect(actual_response.order_id).to eq(order_id)
      expect(actual_response.form_url).to eq(form_url)
      expect(payment.order_id).to eq(order_id)
    end
  end

  context '#refund' do
    include_context 'API Client Refund Order Stub'

    let(:payment) do
      described_class.new(
        order_number: order_number,
        api_client: api_client,
        order_id: order_id
      )
    end
    let(:actual_response) { payment.refund(amount: amount) }

    it 'returns error_code & error_message' do
      expect(actual_response).to be_success
      expect(actual_response.error_code).to eq(error_code)
      expect(actual_response.error_message).to eq(error_message)
    end
  end

  context '#get_info' do
    include_context 'API Client Order Status Stub'

    let(:payment) do
      described_class.new(
        order_number: order_number,
        api_client: api_client,
        order_id: order_id
      )
    end
    let(:actual_response) { payment.get_order_status_extended }

    it 'returns error_code & error_message' do
      expect(actual_response).to be_success
      expect(actual_response).to be_not_paid
      expect(actual_response.error_code).to eq(error_code)
      expect(actual_response.error_message).to eq(error_message)
      expect(actual_response.payment_amount_info.payment_state).to eq('REFUNDED')
    end
  end

  context '#new' do
    let(:order_id) { 'order_id' }
    let(:order_number) { 'order_number' }

    let(:payment) do
      described_class.new(
        order_number: order_number,
        order_id: order_id,
        api_client: OpenStruct.new
      )
    end

    it 'assigns order_id and order_number' do
      expect(payment.order_id).to eq(order_id)
      expect(payment.order_number).to eq(order_number)
    end
  end

  context '#deposit' do
    include_context 'API Client Complete Order Stub'

    let(:payment) do
      described_class.new(
        order_number: order_number,
        api_client: api_client,
        order_id: order_id
      )
    end
    let(:actual_response) { payment.deposit(amount: amount) }

    it 'returns error_code & error_message' do
      expect(actual_response).to be_success
      expect(actual_response.error_code).to eq(error_code)
      expect(actual_response.error_message).to eq(error_message)
    end
  end
end
