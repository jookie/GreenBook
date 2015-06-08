require 'test_helper'

class AppointmentsControllerTest < ActionController::TestCase

  # called before every single test
  setup :initialize_appointment

  # teardown not necessary and may be deleted : to be refactor - by dov
  # called after every single test
  def teardown
    @appointment = nil
  end

  test "should route to index appointments" do
    assert_routing({method: 'get', path: '/appointments'},
                   {controller: "appointments", action: "index"})
  end

  test "should route to show_appointments" do
    assert_routing '/appointments/1',
                   {controller: "appointments", action: "show", id: "1"}
  end

  test "should route to create appointment" do
    assert_routing({method: 'post', path: '/appointments'},
                   {controller: "appointments", action: "create"})
  end

  test "should route to update appointment" do
    assert_routing({method: 'put', path: '/appointments/2'},
                   {:controller => "appointments", :action => "update", id: "2"})
  end

  test "should route to destroy appointment" do
    assert_routing({method: 'delete', path: '/appointments/1'},
                   {controller: "appointments", action: "destroy", id: "1"})
  end

  test "should_not_return_list_of_filtered_appointments" do
    filter_start_time = @appointment.start_time + 1.day
    filter_end_time   = filter_start_time       + 15.minutes
    get :index, start: filter_start_time, end: filter_end_time
    assert_empty assigns(:appointments)
    assert_response :success
    assert_equal 0, assigns(:appointments).count
  end

  test "should_return_list_of_filtered_appointments" do
    get :index, start_time: @appointment.start_time, end_time: @appointment.end_time
    assert_response :success
    assert_not_empty assigns(:appointments)
    assert_equal 4, assigns(:appointments).count
  end

  test "should create appointment" do
    assert_difference('Appointment.count') do
      inc = 2.days
      post :create, appointment: {start_time: @appointment.start_time + inc,
                                  end_time: @appointment.end_time + inc,
                                  first_name: @appointment.first_name,
                                  last_name: @appointment.last_name,
                                  comments: @appointment.comments}
    end
    assert_response :created #HTTP status code: Created 201
  end

  test "should show appointment" do
    get :show, id: @appointment.id
    assert_response :success
  end

  test "should update appointment" do
    inc = 6.days
    patch :update, id: @appointment.id, appointment: {start_time: @appointment.start_time + inc,
                                                      end_time: @appointment.end_time + inc,
                                                      first_name: @appointment.first_name,
                                                      last_name: @appointment.last_name,
                                                      comments: @appointment.comments}
    assert_response :no_content #HTTP status code: No Content 204
  end

  test "should destroy appointment" do
    assert_difference('Appointment.count', -1) do
      delete :destroy, id: @appointment.id
    end
    assert_response :no_content #HTTP status code: No Content 204
  end

  private
  def initialize_appointment
    @appointment = appointments(:start_today_for_30_minutes)
  end
end
