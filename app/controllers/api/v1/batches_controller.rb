class Api::V1::BatchesController < Api::V1::ApiController
    before_action :set_batch, only: [:show, :update, :destroy]
    after_action :set_orders_sent, only: [:sentBatch]
      
    # Create a Batch
    # POST /api/v1/batches
    def create
        orders = []
        @batch = Batch.new(batch_params.merge(reference: '201907-20'))
        orders_references = params[:orders]
        orders_reference.each do |order_reference|
            order = Order.find_by(reference: order_reference)
            if order.purchase_channel == params[:purchase_channel] && order.status == 'ready'
                orders << order
            end
        end
        if orders.count > 0
            @batch.orders = orders
            if @batch.save
                @batch.orders.each do |order|
                    order.update_attribute(:status, 'production')
                end
                render json: {batch_reference: @batch.reference, qtd_orders: orders.count, orders: orders}, status: :created
            else
                render json: @batch.errors, status: :unprocessable_entity
            end
        end
        render json: {error: "Batch without orders from the informed purchase channel;", status: 400}, status: :bad_request
    end

    # Produce a Batch
    # PATCH /api/v1/batches/produceBatch
    def produceBatch
        if params[:reference]
            @batch = Batch.find_by(reference: params[:reference])
            @batch.orders.each do |order|
                if order.status == 'production'
                    order.update_attribute(:status, 'closing')
                end
            end
            render json: {}, status: :ok
        else
            render json: {error: "Missing Parameters Required;", status: 422}, status: :unprocessable_entity
        end
    end

    # Close part of a Batch for a Delivery Service
    # PATCH /api/v1/batches/sentBatch
    def sentBatch
        if params[:reference] && params[:delivery_service]
            @batch = Batch.find_by(reference: params[:reference])
            @batch.orders.each do |order|
                if order.delivery_service == params[:delivery_service] && order.status == 'closing'
                    order.update_attribute(:status,'sent')
                end
            end
            render json: {}, status: :ok
        else
            render json: {error: "Missing Parameters Required;", status: 422}, status: :unprocessable_entity
        end
    end
        
    # GET /api/v1/batches
    def index
        @batches = Batch.all
        render json: @batches
    end

    # GET /api/v1/batches/1
    def show
        render json: @batch
    end

    # PATCH/PUT /api/v1/batches/1
    def update
        if @batch.update(batch_params)
          render json: @batch
        else
          render json: @batch.errors, status: :unprocessable_entity
        end
    end

    # DELETE /api/v1/batches/1
    def destroy
        @batch.destroy
    end

    # GET /api/v1/batches
    def orders
        ordersarray = []
        @batches = Batch.all
        @batches.each do |order|
            ordersarray << order.orders
        end
        render json: ordersarray
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_batch
            @batch = Batch.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def batch_params
            params.permit(:purchase_channel)
        end

        def set_orders_sent
            orders = Order.where(["delivery_service = ?", params[:delivery_service]])
            orders.each do |order|
                if order.status == 'closing'
                    order.update_attribute(:status, 'sent')
                end
            end
        end
end
