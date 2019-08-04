require 'rails_helper'

RSpec.describe 'Orders API', type: :request do
    before {  host! 'localhost:3000' }

    describe 'GET /orders' do
        let!(:order) { create(:order, status: 'ready') }
        before do
            get "/api/v1/orders" 
        end

        it 'returns orders' do
            expect(json[0]['reference'].to_s).to eq(order.reference.to_s)
        end
    
        it 'when valid' do
            expect(response).to have_http_status(200)
        end
    end

    describe 'GET /orders/status' do
        let!(:order) { create(:order, status: 'ready') }
        before do
            get "/api/v1/orders/status", params: order_params 
        end
        context "when the params valids" do
            let(:order_params) {{ reference: order.reference }}
            it 'returns status orders' do
                expect(json[0]['reference'].to_s).to eq(order.reference.to_s)
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

    describe 'GET /orders/status/pipeline' do
        let!(:order) { create(:order, status: 'ready') }
        before do
            get "/api/v1/orders/pipeline", params: order_params 
        end
        context "when the params valids" do
            let(:order_params) {{ purchase_channel: order.purchase_channel, status: 'ready' }}
            it 'returns orders' do
                expect(json[0]['reference'].to_s).to eq(order.reference.to_s)
            end
        
            it 'valid' do
                expect(response).to have_http_status(200)
            end
        end
        context 'when the params invalids' do
            let(:order_params) {{reference: ''}}
            
            it 'returns status code 400' do
              expect(response).to have_http_status(400)
            end
        end
    end

    describe 'GET /orders/status/financialReport' do
        let!(:order) { create(:order, status: 'ready') }
        before do
            get "/api/v1/orders/financialReport", params: {} 
        end
        context "when get financial Report" do
            it 'returns orders' do
                expect(json[0]['purchase_channel'].to_s).to eq(order.purchase_channel.to_s)
            end
        
            it 'valid' do
                expect(response).to have_http_status(200)
            end
        end
    end

    # Test suite for POST /orders
    #describe 'POST /orders' do  
    #    before do
    #        post "/api/v1/orders", params: valid_attributes
    #    end
    #    context 'when the request is valid' do
    #        #let(:order) { build(:order, reference: 'UHFG641JFFNB') }
    #        let(:valid_attributes) { attributes_for(:order) }
    #        
    #        #it 'creates a order' do
    #        #    response = JSON.parse(response.body)
    #        #    #expect(Order.last).to have_attributes(attributes)
    #        #    expect(response['reference'].to_s).to eq('UHFG641JFFNB')
    #        #end
    #        # verifica se o objeto esta atualizado
    #        #expect(order.reload).to have_attributes(json_response.expect('created_at', 'updated_at'))
    #        it 'when created' do
    #            expect(response).to eq('201')
    #        end
    #        #Intesting
    #        #expect{
    #        #   post '/api/v1/orders', params {order: invallid_attributes}
    #        #}.to_not change(Order, :count)
    #        #
    #        #Verificar se atualizou no bd
    #        #expect(order.reload).to have_attributes(order_attributes)
    #    end
    #    context 'when the request is invalid' do
    #        let(:valid_attributes)  { { reference: 'Foobar' } }
    #           it 'when not valid' do
    #            expect(response).to have_http_status(422)
    #        end
    #    end
    #end    
end