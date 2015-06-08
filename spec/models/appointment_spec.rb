require 'rails_helper'

=begin
RSpec.describe Appointment, type: :model do
  it 'returns appointment' do
    # setup
    result = Appointment.create(
        :start_time => Date.today,
        :end_time => Date.today + 30.minutes,
        first_name: 'Rina',
        last_name: 'Dror',
        comments: "start_now_for_30_minutes")
    # exercise

    expect(result).to eq [appointment.name]
  end
end
=end
