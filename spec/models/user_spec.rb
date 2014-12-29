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

		it 'overrides current_sign_in_ip' do
			user.current_sign_in_ip=("100.0.0.1")
			user.reload
			expect(user.current_sign_in_ip).to eq(1677721601)
		end

		it 'overrides last_sign_in_ip' do
			user.last_sign_in_ip=("100.0.0.1")
			user.reload
			expect(user.last_sign_in_ip).to eq(1677721601)
		end

	end

	describe 'class' do

		it 'has a STATUS hash' do
			expect(User::STATUSES).to be
		end

		describe "User.string_ip_to_integer" do
			it 'converts string ips correcty' do
				expect(User.string_ip_to_integer("127.0.0.1")).to eq(2130706433)
			end

			it 'doesnt convert integer ips' do
				expect(User.string_ip_to_integer(2130706433)).to eq(2130706433)
			end
		end
	end


end