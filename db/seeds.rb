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

# [  "Zon Utara",
#    "Zon Barat",
#    "Zon Tengah 1",
#    "Zon Tengah 2",
#    "Zon Selatan",
#    "Zon Timur",
#    "Zon Borneo 1",
#    "Zon Borneo 2"
#  ].each do |zone|
#      Staff::Zone.find_or_create_by(title: zone)
#    end

[
  ["PG", "Penjaring Gol"],
  ["SP", "Sepakan Penalti"],
  ["GS", "Gol Sendiri"],
  ["PK", "Pemain Keluar"],
  ["PM", "Pemain Masuk"],
  ["K1", ""],
  ["K2", ""],
  ["K3", ""],
  ["K4", ""],
  ["K5", ""],
  ["K6", ""],
  ["K7", ""],
  ["M1", ""],
  ["M2", ""],
  ["M3", ""],
  ["M4", ""],
  ["M5", ""],
  ["M6", ""],
  ["M7", ""]
].each do |kod_number, kod_name|
  Kod.find_or_create_by(kod_number: kod_number, kod_name: kod_name)
end

# SystemPreference.find_or_create_by(created_at: Date.today, updated_at: Date.today)
