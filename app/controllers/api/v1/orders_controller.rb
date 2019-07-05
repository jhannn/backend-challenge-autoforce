class Api::V1::OrdersController < ApplicationController
    before_action :set_order, only: [:show, :update, :destroy]
    
    # GET /api/v1/orders
    def index
        @orders = Order.all
        render json: @orders
    end

    # GET /api/v1/orders/1
    def show
        render json: @order
    end
      
    # POST /api/v1/orders
      
    def create
        @order = Order.new(order_params.merge(status: 'ready'))
        if @order.save
            render json: @order, status: :created
        else
            render json: @order.errors, status: :unprocessable_entity
        end
    end
      
    # PATCH/PUT /api/v1/orders/1
    def update
        if @order.update(order_params)
          render json: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
    end

    # DELETE /api/v1/orders/1
    def destroy
        @order.destroy
    end

    # GET /api/v1/orders/getStatus
    def getStatus
        if params[:reference]
            @orders = Order.where(["reference = ?", params[:reference]])
            @orders = @orders.page(params[:page] || 1).per(params[:per_page] || 10)
        elsif params[:client_name]
            @orders = Order.where(["client_name = ?", params[:client_name]])
            @orders = @orders.page(params[:page] || 1).per(params[:per_page] || 10)
        end
        render json: @orders || []
    end    

    # GET /api/v1/orders/pipeline
    def pipeline
        if params[:purchase_channel] && params[:status]
            @orders = Order.where(["purchase_channel = ? AND status = ?", params[:purchase_channel], params[:status]])
            @orders = @orders.page(params[:page] || 1).per(params[:per_page] || 10)
        elsif params[:purchase_channel]
            @orders = Order.where(["purchase_channel = ?", params[:purchase_channel]])
            @orders = @orders.page(params[:page] || 1).per(params[:per_page] || 10)
        end
        render json: @orders || []
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_order
          @order = Order.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def order_params
          params.permit(:reference, :purchase_channel, :client_name, :address, :delivery_service, :total_value, :line_items)
        end
      
end