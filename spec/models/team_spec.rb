require 'rails_helper'

RSpec.describe Team, :type => :model do
	let(:team) {create(:team)}
	let(:team_with_4) {create(:team_with_4_users)}

	it 'should have valid factories' do
		expect(
			create(:team)
		).to be_valid
		expect(
			create(:team_with_4_users)
		).to be_valid
	end

	describe 'class' do

		it 'should be able to have users' do
			expect(team_with_4.users.count).to eq(4)
		end

		it 'needs a name' do
			team = {name: nil}
			team = Team.new(team)
			team.save
			expect(team.errors).to have_key(:name)
		end


	end
end
