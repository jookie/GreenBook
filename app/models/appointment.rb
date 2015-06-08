#\app\models\appointment.rb
#Model the appointments resource.
#When creating or updating a resource, it should only be considered valid if
#the start and end times are in the future and do not overlap an existing appointment on the same day.
#Attrtibutes:
#Appointment start_time:datetime end_time:datetime first_name:string last_name:string comments:string
class Appointment < ActiveRecord::Base

  validates :start_time, :presence => true
  validates :end_time  , :presence => true
  validate  :time_slot_is_available
  validate  :start_time_is_before_end_time
  validate  :start_time_is_not_in_the_past

  # Filter appointments by start and/or end dates
  def Appointment.in_time_slot_only(params)
    params.inject(Appointment) { |booking_scope, (key, value)|
      case key.to_sym
        when :start
          booking_scope.where("start_time >= ?", value.to_date)
        when :end
          booking_scope.where("end_time   <= ?", value.to_date)
        else
          booking_scope
      end
    }
  end

  # Filter appointments by start and/or end dates not working tdd
  scope :in_time_slot_only2, ->(params) {
    where('start_time > ? AND end_time < ?' , (params[:start_time].to_date unless params[:start].nil?), (params[:end_time].to_date unless params[:end].nil?))}

  # special user story appointment is valid if:
  #start_time = par_end_time AND end_time > par_start_time OR start_time < par_end_time AND end_time = par_start_time
  scope :taken, ->(par_start_time, par_end_time) do
    where 'start_time < ? AND end_time > ?', par_end_time, par_start_time
  end

  private
  def start_time_is_before_end_time
    errors.add(:start_time, 'Start time is before end time') unless (start_time < end_time) if start_time && end_time
  end

  def start_time_is_not_in_the_past
    today = Date.today
    errors.add(:start_time, 'Start time is in the past') unless start_time > today if start_time && end_time
  end

  def time_slot_is_available
    errors.add(:base, 'Time slot is taken') if Appointment.where.not(id: id).taken(start_time, end_time).exists?
  end

end

