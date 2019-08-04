class Api::V1::BatchesController < Api::V1::ApiController
    after_action :set_orders_sent, only: [:sent]
      
    # Create a Batch
    # POST /api/v1/batches
    def create
        orders = []
        if params[:orders] && !params[:orders].blank? && params[:purchase_channel] && !params[:purchase_channel].blank?
            JSON.parse(params[:orders]).each do |order|
                order = Order.find_by(reference: order['reference'])
                if order.purchase_channel == params[:purchase_channel] && order.status == 'ready'
                    orders << order
                end
            end
            if orders.count > 0
                last_batch = Batch.last
                last_batch_id = 0
                if  last_batch === nil
                    last_batch_id = 0
                else
                    last_batch_id = last_batch.id
                end
                @batch = Batch.new(batch_params.merge(orders: orders, reference: Time.now.strftime("%Y%m") + '-' + ((last_batch_id + 1).to_s)))
                if @batch.save
                    @batch.orders.each do |order|
                        order.update_attribute(:status, 'production')
                    end
                    render json: {batch_reference: @batch.reference, qtd_orders: orders.count, orders: orders}, status: :created
                    return
                else
                    render json: @batch.errors, status: :unprocessable_entity
                    return
                end
            end
            render json: {error: "batch without orders from the informed purchase channel"}, status: :unprocessable_entity
        else
            render json: {error: "bad parameters"}, status: :bad_request
        end
    end

    # Produce a Batch
    # PATCH /api/v1/batches/produce
    def produce
        if params[:reference] && !params[:reference].blank?
            @batch = Batch.find_by(reference: params[:reference])
            if @batch == nil
                render json: {error: "batch not found"}, status: :unprocessable_entity
                return
            end
            @batch.orders.each do |order|
                if order.status == 'production'
                    order.update_attribute(:status, 'closing')
                end
            end
            render json: {}, status: :ok
        else
            render json: {error: "bad parameters"}, status: :bad_request
        end
    end

    # Close part of a Batch for a Delivery Service
    # PATCH /api/v1/batches/sent
    def sent
        if params[:reference] && !params[:reference].blank? && params[:delivery_service] && !params[:delivery_service].blank?
            @batch = Batch.find_by(reference: params[:reference])
            if @batch == nil
                render json: {error: "batch not found"}, status: :unprocessable_entity
                return
            end
            @batch.orders.each do |order|
                if order.delivery_service == params[:delivery_service].downcase && order.status == 'closing'
                    order.update_attribute(:status, 'sent')
                end
            end
            render json: {}, status: :ok
        else
            render json: {error: "bad parameters"}, status: :bad_request
        end
    end
        
    # GET /api/v1/batches
    def index
        @batches = Batch.all
        render json: @batches, status: :ok
    end

    private
        # Only allow a trusted parameter "white list" through.
        def batch_params
            params.permit(:orders, :purchase_channel)
        end

        def set_orders_sent
            if params[:delivery_service] && !params[:delivery_service].blank?
                orders = Order.where(["delivery_service = ? AND status = ?", params[:delivery_service].downcase, 'closing'])
                orders.each do |order|
                    order.update_attribute(:status, 'sent')
                end
            end
        end
end
