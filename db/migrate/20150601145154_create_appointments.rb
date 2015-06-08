class CreateAppointments < ActiveRecord::Migration
  # scaffold Appointment start_time:datetime end_time:datetime first_name:string last_name:string comments:string
  def change
    create_table :appointments do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :first_name
      t.string :last_name
      t.string :comments
    end
  end
end
