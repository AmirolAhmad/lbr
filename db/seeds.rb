# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# State:
# [ "Johor",
#   "Kedah",
#   "Kelantan",
#   "Kuala Lumpur",
#   "Labuan",
#   "Malacca",
#   "N. Sembilan",
#   "Pahang",
#   "P. Pinang",
#   "Perak",
#   "Perlis",
#   "Sabah",
#   "Sarawak",
#   "Selangor",
#   "Terengganu"
# ].each do |state|
#     State.find_or_create_by(name: state)
#   end

[  "Zon Utara",
   "Zon Barat",
   "Zon Tengah 1",
   "Zon Tengah 2",
   "Zon Selatan",
   "Zon Timur",
   "Zon Borneo 1",
   "Zon Borneo 2"
 ].each do |zone|
     Staff::Zone.find_or_create_by(title: zone)
   end

# SystemPreference.find_or_create_by(created_at: Date.today, updated_at: Date.today)
