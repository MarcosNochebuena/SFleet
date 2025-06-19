class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[ show update destroy update_status ]
  has_scope :status, :license_plate, :make, :by_model, :year, only: %i[ index ]

  # GET /vehicles
  def index
    @vehicles = apply_scopes(Vehicle).all

    render json: @vehicles
  end

  # GET /vehicles/1
  def show
    render json: @vehicle
  end

  # POST /vehicles
  def create
    @vehicle = Vehicle.new(vehicle_params)

    if @vehicle.save
      render json: @vehicle, status: :created, location: @vehicle
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /vehicles/1
  def update
    if @vehicle.update(vehicle_params)
      render json: @vehicle
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  def update_status
    @vehicle.update(status: vehicle_params[:status])
    render json: @vehicle
  end

  # DELETE /vehicles/1
  def destroy
    @vehicle.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def vehicle_params
      params.expect(vehicle: [ :license_plate, :make, :model, :year, :status ])
    end
end
