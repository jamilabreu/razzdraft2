require 'csv'

puts "CREATE ADMIN"
AdminUser.create name: "Jamil Abreu", email: 'abreu.jamil@gmail.com', password: 'password', password_confirmation: 'password'

puts "CREATE TEAMS"
teams = %W[ #{'New York Yankees'} #{'New York Mets'} ]
positions = %w( 1B 2B SS 3B SP RP )

puts "CREATE PROJECTIONS"
CSV.foreach("#{Rails.root}/lib/data/baseball_projections_2013.csv", encoding: "ISO8859-1:utf-8", headers: true) do |row|
	BaseballProjection.create(
		name: "#{row[1]} #{row[2]}",
		first_name: row[1],
		last_name: row[2],
		positions: row[4].nil? ? [] : row[4].split(","),
		team: "New York Yankees",
		team_abbreviation: "NYY",
		rank: 			row[0],
		runs: 			row[5].nil? ? 0 : row[5],
		homeruns: 	row[6].nil? ? 0 : row[6],
		rbi: 				row[7].nil? ? 0 : row[7],
		average: 		row[8].nil? ? 0 : row[8],
		steals: 		row[9].nil? ? 0 : row[9],
		wins: 			row[10].nil? ? 0 : row[10],
		losses: 		row[11].nil? ? 0 : row[11],
		era: 				row[12].nil? ? 0 : row[12],
		whip: 			row[13].nil? ? 0 : row[13],
		strikeouts: row[14].nil? ? 0 : row[14],
		saves: 			row[15].nil? ? 0 : row[15],
		blurb: 			row[16].nil? ? nil : row[16],
		year: 2013,
		owner: "Grey Albright"
	)
end

CSV.foreach("#{Rails.root}/lib/data/nfl_2011.csv", encoding: "ISO8859-1:utf-8", headers: true) do |row|
	FootballProjection.create(
		name: row[0],
		team: row[1],
		positions: ["QB"],
		games: row[2],
		qbr: row[3],
		comp: row[4],
		att: row[5],
		pct: row[6],
		touchdowns: row[10]
	)
end
# puts "CREATE USERS"
# 20.times do
#   random_uid = rand(300000..302715)
#   User.create(
#     name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
#     email: Faker::Internet.email,
#     password: "password",
#     description: Faker::Lorem.paragraph
#   )
# end
