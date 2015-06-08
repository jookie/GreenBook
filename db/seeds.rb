# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

path = Rails.root.join('db', 'Carecloud Ruby test part 2.xlsx')
puts "Reading appointments records from: #{path}"
parse = RubyXL::Parser.parse(path)
table = parse[0].get_table(['start_time', 'end_time', 'first_name', 'last_name', 'comments'])
appointments = table[:table].map {|appointment| Appointment.new(appointment)}
puts "Appointments count: #{appointments.count}"
Appointment.import appointments, :validate => false
imported_count = Appointment.count
puts "Appointments count in data base #{imported_count} records"