class MaintenanceReportsController < ApplicationController
  before_action :set_maintenance_report, only: %i[ show update destroy ]
  has_scope :description, :priority, :status, :vehicle_id, :report_date, only: %i[ index ]

  # GET /maintenance_reports
  def index
    @maintenance_reports = apply_scopes(MaintenanceReport).all

    render json: @maintenance_reports
  end

  # GET /maintenance_reports/1
  def show
    render json: @maintenance_report
  end

  # POST /maintenance_reports
  def create
    @maintenance_report = MaintenanceReport.new(maintenance_report_params)
    @maintenance_report.report_date = Date.current if @maintenance_report.report_date.blank?

    @maintenance_report.save!
    render json: @maintenance_report, status: :created, location: @maintenance_report
  end

  # PATCH/PUT /maintenance_reports/1
  def update
    @maintenance_report.update!(maintenance_report_params)
    render json: @maintenance_report
  end

  # DELETE /maintenance_reports/1
  def destroy
    @maintenance_report.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintenance_report
      @maintenance_report = MaintenanceReport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def maintenance_report_params
      params.require(:maintenance_report).permit(:vehicle_id, :description, :report_date, :priority, :status)
    end
end
