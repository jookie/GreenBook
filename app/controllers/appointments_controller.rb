#app/controllers/appointments_controller.rb
# This class exposes the following methods to facilitate CRUD operations on the appointment
# Create
# Update
# Delete
# List (accepts optional start/end time parameters to filter data)
# All operations returns valid JSON
# along with the appropriate HTTP status codes.
# - Create POST     /appointments
# - Update PUT      /appointments/:id
# - Delete DELETE   /appointments/:id
# - List   GET      /appointments   Should accept optional start/end time parameters to filter data.
# - Show   appointments/:id
class AppointmentsController < ApplicationController

  include ApplicationHelper

  # GET /appointments
  # GET /appointments.json
  def index
    if !time_slot_params[:start].present? && !time_slot_params[:end].present?
      @appointments = Appointment.all
    else
      #time_slot_params[:start], time_slot_params[:end]
      @appointments = Appointment.in_time_slot_only(time_slot_params).all
    end
    render :json => @appointments, :status => :ok
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    begin
      @appointment = Appointment.find(params[:id])
    rescue
      respond_info('error', 'internal_server_error', 'Show appointment Failed', :internal_server_error)
      return
    end
    render :json => @appointment, :status => :ok
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      render json: @appointment, status: :created, location: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    begin
      @appointment = Appointment.find(params[:id])
    rescue
      respond_info('error', 'internal_server_error', 'Update Appointment Failed', :internal_server_error)
      return
    end
    if @appointment.update(appointment_params)
      render :json => @appointments, :status => :no_content #HTTP status code: 204 No Content
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    begin
      @appointment = Appointment.find(params[:id])
    rescue
      respond_info('error', 'internal_server_error', 'Delete Appointment Failed', :internal_server_error)
      return
    end
    @appointment.destroy
    respond_info('success', 'success', 'Success', :no_content) #HTTP status code: No Content
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  # Never trust parameters from the scary internet, only allow the white list through.
  def appointment_params
    params.require(:appointment).permit(:start_time, :end_time, :first_name, :last_name, :comments)
  end

  def time_slot_params
    params.permit(:start, :end)
  end

  def respond_info(status, code, message, http_hdr_status)
    render :json => {:status => status, :data => {:code => code, :message => message}}.to_json, :status => http_hdr_status
  end

end
