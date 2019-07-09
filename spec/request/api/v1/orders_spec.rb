RSpec.describe 'Orders API', type: :request do
    # initialize test data 
    let!(:order) { create(:order) }
    let(:headers) do
        {
          'Accept' => 'application/vnd.api+json',
          'Content-Type' => Mime[:json].to_s
        }
    end

    before {  host! 'localhost:3000' }
  
    # Test suite for GET /orders
    describe 'GET /orders' do
      before do
        get "/api/v1/orders", params: {}, headers: headers 
      end

      it 'returns orders' do
        orders_response = JSON.parse(response.body)
        expect(orders_response[0]['reference'].to_s).to eq(order.reference.to_s)
      end
  
      it 'when valid' do
        expect(response).to have_http_status(200)
      end
    end

    # Test suite for GET /orders/status
    describe 'GET /orders/status' do
      before do
        get "/api/v1/orders/status", params: order_params, headers: headers 
      end
        context "when the params valids" do
            let(:order_params) {{ reference: order.reference }}
            it 'returns status orders' do
                orders_response = JSON.parse(response.body)
                expect(orders_response[0]['reference'].to_s).to eq(order.reference.to_s)
            end
        
            it 'when valid' do
                expect(response).to have_http_status(200)
            end
        end
        context 'when the params invalids' do
            let(:order_params) {{purchase_channel: ''}}
            
            it 'returns status code 400' do
                expect(response).to have_http_status(400)
            end
        end
    end

    # Test suite for GET /orders/pipeline
    describe 'GET /orders/status/pipeline' do
        before do
            get "/api/v1/orders/pipeline", params: order_params, headers: headers 
        end
        context "when the params valids" do
            let(:order_params) {{ purchase_channel: order.purchase_channel, status: 'ready' }}
            it 'returns orders' do
                orders_response = JSON.parse(response.body)
                expect(orders_response[0]['reference'].to_s).to eq(order.reference.to_s)
            end
        
            it 'valid' do
                expect(response).to have_http_status(200)
            end
        end
        context 'hen the params invalids' do
            let(:order_params) {{reference: ''}}
            
            it 'returns status code 400' do
              expect(response).to have_http_status(400)
            end
        end
    end

    # Test suite for GET /orders/financialReport
    describe 'GET /orders/status/financialReport' do
        before do
            get "/api/v1/orders/financialReport", params: {}, headers: headers 
        end
        context "when get financial Report" do
            it 'returns orders' do
                orders_response = JSON.parse(response.body)
                expect(orders_response[0]['purchase_channel'].to_s).to eq(order.purchase_channel.to_s)
            end
        
            it 'valid' do
                expect(response).to have_http_status(200)
            end
        end
    end

    # # Test suite for POST /orders
    # describe 'POST /orders' do  
    #     before do
    #         post '/api/v1/orders', params: { order: valid_attributes }, headers: headers
    #     end
    #     context 'when the request is valid' do
    #         let(:valid_attributes) { attributes_for(:order, reference: 'BAR87634H') }
    #         it 'creates a order' do
    #             expect(json['reference']).to eq('BR1100')
    #         end
    
    #         it 'when created' do
    #             expect(response).to have_http_status(201)
    #         end
    #     end
    
    #     context 'when the request is invalid' do
    #         let(:valid_attributes)  { { reference: 'Foobar' } }
    
    #         it 'when not valid' do
    #             expect(response).to have_http_status(422)
    #         end
    #     end
    # end
end