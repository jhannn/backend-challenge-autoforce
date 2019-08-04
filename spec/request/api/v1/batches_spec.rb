require 'rails_helper'

RSpec.describe 'Batches API', type: :request do
    before {  host! 'localhost:3000' }
    describe 'GET /batches' do
        let!(:batch) { create(:batch) }
        before do
            get "/api/v1/batches" 
        end

        it 'returns batches' do
            expect(json[0]['reference'].to_s).to eq(batch.reference.to_s)
        end
    
        it 'when valid' do
            expect(response).to have_http_status(200)
        end
    end

    describe 'PATCH /api/v1/batches/produce' do
        context 'when the batch exists' do
            let(:batch) {create(:batch)}
            before(:each) {patch '/api/v1/batches/produce', params: {reference: batch.reference}}
            it 'return status code 200' do
                expect(response).to have_http_status(200)
            end
        end
        context 'when the batch not exists' do
            let(:attributes_batch) {}
            before(:each) {patch '/api/v1/batches/produce', params: attributes_batch}
            it 'params invalid' do
                expect(response).to have_http_status(400)
            end
        end
        context 'when the batch not exists' do
            let(:attributes_batch) {{reference: 'YTDSJBBHF90'}}
            before(:each) {patch '/api/v1/batches/produce', params: attributes_batch}
            it 'params valid' do
                expect(response).to have_http_status(422)
            end
        end
    end

    describe 'PATCH /api/v1/batches/sent' do
        context 'when the batch exists and not exists orders with "closing"' do
            let(:batch) {create(:batch)}
            let(:batch_attributes) {attributes_for(:batch)}
            before(:each) {patch '/api/v1/batches/sent', params: {reference: batch.reference, delivery_service: batch.orders[0].delivery_service}}
            it 'return status code 200' do
                expect(response).to have_http_status(200)
            end
            it 'not changed orders in batch' do
                #expect(batch.reload).to have_attributes(batch_attributes)
            end
        end
        context 'when the batch exists and exists orders with "closing"' do
            let(:batch) {create(:batch, orders:[create(:order, status: 'closing')])}
            let(:batch_attributes) {attributes_for(:batch)}
            before(:each) {patch '/api/v1/batches/sent', params: {reference: batch.reference, delivery_service: batch.orders[0].delivery_service}}
            it 'return status code 200' do
                expect(response).to have_http_status(200)
            end
            it 'not changed ordes in batch' do
                #expect(batch.reload).to have_attributes(batch_attributes)
            end
        end
        context 'when the batch not exists' do
            let(:attributes_batch) {{}}
            before(:each) {patch '/api/v1/batches/sent', params: attributes_batch}
            it 'with params invalid' do
                expect(response).to have_http_status(400)
            end
        end
        context 'when the batch not exists' do
            let(:attributes_batch) {{reference: 'YTDSJBBHF90', delivery_service: 'Sedex'}}
            before(:each) {patch '/api/v1/batches/sent', params: attributes_batch}
            it 'with params valid' do
                expect(response).to have_http_status(422)
            end
        end
    end
end