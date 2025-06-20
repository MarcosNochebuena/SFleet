class ServiceOrdersController < ApplicationController
  before_action :set_service_order, only: %i[ show update destroy update_status ]
  has_scope :status, :vehicle_id, :maintenance_report_id, :creation_date, :estimated_cost, only: %i[ index ]

  # GET /service_orders
  def index
    @service_orders = apply_scopes(ServiceOrder).all

    render json: @service_orders
  end

  # GET /service_orders/1
  def show
    render json: @service_order
  end

  # POST /service_orders
  def create
    @service_order = ServiceOrder.new(service_order_params)
    @service_order.creation_date = Date.current if @service_order.creation_date.blank?

    @service_order.save!
    render json: @service_order, status: :created, location: @service_order
  end

  # PATCH/PUT /service_orders/1
  def update
    @service_order.update(service_order_params)
    render json: @service_order
  end

  def update_status
    @service_order.update(status: service_order_params[:status])
    render json: @service_order, status: :ok
  end

  # DELETE /service_orders/1
  def destroy
    @service_order.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_order
      @service_order = ServiceOrder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def service_order_params
      params.require(:service_order).permit(:vehicle_id, :maintenance_report_id, :creation_date, :status, :estimated_cost)
    end
end
