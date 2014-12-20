namespace :teams do
	task create: [:environment] do
		if Team.count == 0
			teams = %w( CustomerSupport Marketing SalesPeople Reps Managers )
			teams.each do |team|
				Team.create({name: team})
			end
		end

		User.all.each do |user|
			user.team = Team.all.sample
			user.save
		end		
	end
end
