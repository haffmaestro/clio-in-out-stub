require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
	
	let(:user) {create(:user)}
	let(:user_2) {create(:user)}
	login_user

	it "should have a current_user" do
	  expect( subject.current_user).to be
	end

	describe '#index' do
		it 'should assing the users variable' do
			get :index
			expect(assigns(:users)).to eq([user, user_2])
		end

		it 'renders json' do
			user
			user_2
			get :index, format: 'json'
			json = JSON.parse(response.body)
			expect(json["users"].count).to eq(2)
		end
	end

end