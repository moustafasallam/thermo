# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

locations = [
  'Cairo/Egypt',
  'Giza/Egypt',
  'Alexandria/Egypt',
  'Minia/Egypt',
  'Portsaid/Egypt',
  'Luxor/Egypt',
  'Aswan/Egypt',
  'Asuit/Egypt',
  'Nairobi/Kenya',
  'Kigali/Rowanda',
  'Acra/Ghana',
  'Lagos/Nigeria',
  'Kampala/Uganda',
]

0..90.times do |n|
  thermo = Thermostat.create!({location: locations.sample(1).first})
  thermo.save!
end