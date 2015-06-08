require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase

  test('should not validate with end_time smaller than start_time') {
    appointment = appointments(:end_time_greater)
    assert_not appointment.valid?, 'end_time is smaller than start_time'}

  # redundant : to be refactor - by dov
  test('missing times') {
    appointment = Appointment.new
    assert_not appointment.save,   'should not save the appointment without times'
    assert_not appointment.valid?, 'should not validate the appointment without times'
  }

  test('missing start_time') {
    appointment= appointments(:start_today_for_30_minutes)
    appointment.start_time = nil
    assert_not appointment.valid?, 'start_time is missing'
  }

  # redundant : to be refactor - by dov
  test('missing end_time') {
    appointment= appointments(:start_today_for_30_minutes)
    appointment.end_time = nil
    assert_not appointment.valid?, 'end time is missing'
  }

  test('should not validate with start_time equal or lesser than today') {
    appointment = Appointment.new(:start_time => (Date.today - 1.hour), :end_time => (Date.today + 1.hour))
    assert_not appointment.valid?, 'start_time in the past'
  }

  test('should not validate with end_time equal or lesser than today') {
    appointment= appointments(:start_today_for_30_minutes)
    appointment.end_time = Date.today
    assert_not appointment.valid?, 'end_time in the past'
  }

  # redundant : to be refactor - by dov
  test('should not validate taken time slot 2') {
    appointment = appointments(:taken_2)
    assert_not appointment.valid?
  }

  test('should not validate if taken_earlier_today') {
    appointment = appointments(:taken_earlier_today)
    assert_not appointment.valid?, 'should not validate taken time slot'
  }

  test('find it if filtered by equal or greater end time and by equal or smaller start time') {
    #add a valid appointment to the database
    appointment = appointments(:start_today_for_30_minutes)
    #in_time_slot_only for the appointment
    appointments = Appointment.in_time_slot_only(:start => appointment.start_time, :end => (appointment.end_time))
    assert appointments.exists?, 'filtered  by equal or greater end time and by equal or smaller start time'
  }

  test('should search by start date only') {
    appointment = Appointment.in_time_slot_only(start: Date::yesterday)
    assert appointment.exists?, 'should find it'
  }

  test('search by end date only') {
    appointment = Appointment.in_time_slot_only(end: Date::yesterday)
    assert_not appointment.exists?, 'should not find it'
  }

end
