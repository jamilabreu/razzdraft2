require 'csv'

puts "CREATE ADMIN"
AdminUser.create name: "Jamil Abreu", email: 'abreu.jamil@gmail.com', password: 'password', password_confirmation: 'password'

puts "CREATE PROJECTIONS"
CSV.foreach("#{Rails.root}/lib/data/baseball_projections_2013.csv", encoding: "ISO8859-1:utf-8", headers: true) do |row|
	BaseballProjection.create(
		_id: 								row[0],
		name: 							row[1],
		first_name: 				row[1].split(" ").first,
		last_name: 					row[1].split(" ").last,
		team: 							"New York Yankees",
		team_abbreviation: 	row[2],
		espn_positions: 		row[3].split(","),
		yahoo_positions: 		row[5].split(","),
		rank: 							row[7],
		plate_appearances:	row[8].nil? ? 0 : row[8],
		at_bats: 						row[9].nil? ? 0 : row[9],
		runs: 							row[10].nil? ? 0 : row[10],
		homeruns: 					row[11].nil? ? 0 : row[11],
		rbi: 								row[12].nil? ? 0 : row[12],
		steals: 						row[13].nil? ? 0 : row[13],
		average: 						row[14].nil? ? 0 : row[14],
		obp: 								row[15].nil? ? 0 : row[15],
		hits:       				row[16].nil? ? 0 : row[16],
		times_on_base: 			row[17].nil? ? 0 : row[17],
		innings_pitched: 		row[18].nil? ? 0 : row[18],
		wins: 							row[19].nil? ? 0 : row[19],
		losses: 						row[20].nil? ? 0 : row[20],
		era: 								row[21].nil? ? 0 : row[21],
		whip: 							row[22].nil? ? 0 : row[22],
		strikeouts: 				row[23].nil? ? 0 : row[23],
		saves: 							row[24].nil? ? 0 : row[24],
		earned_runs: 		 		row[25].nil? ? 0 : row[25],
		basemen_allowed: 		row[26].nil? ? 0 : row[26],
		blurb: 							row[27].nil? ? nil : row[27],
		year: 							2013,
		owner: 							"Grey Albright"
	)
end

# CSV.foreach("#{Rails.root}/lib/data/nfl_2011.csv", encoding: "ISO8859-1:utf-8", headers: true) do |row|
# 	FootballProjection.create(
# 		name: row[0],
# 		team: row[1],
# 		positions: ["QB"],
# 		games: row[2],
# 		qbr: row[3],
# 		comp: row[4],
# 		att: row[5],
# 		pct: row[6],
# 		touchdowns: row[10]
# 	)
# end
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
