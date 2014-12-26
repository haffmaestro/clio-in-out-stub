FactoryGirl.define do
  factory :team do
  	name {Faker::Commerce.department}

  	
  	factory :team_with_4_users do
  		transient do 
  			users_count 4
  		end
  		after(:create) do |team, evaluator|
  			create_list(:user, evaluator.users_count, team: team)
  		end
  	end
  end
end