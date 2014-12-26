require 'rails_helper'

RSpec.describe User, :type => :model do
	let(:user) {create(:user)}

	it 'should have a valid factory' do
		expect(create(:user)).to be_valid
	end

	describe 'instance methods' do

		it '#status' do
			user.status=(:out)
			user.save
			user.reload
			expect(user.status).to eq(:out)
		end

		it '#full_name' do
			expect(user.full_name).to eq(user.first_name+" "+user.last_name)
		end

	end

	describe 'class' do

		it 'has a STATUS hash' do
			expect(User::STATUSES).to be
		end
	end


end