require 'rails_helper'

RSpec.describe TeamsController, :type => :controller do

  let(:team) {create(:team)}
  let(:team_2) {create(:team)}
  login_user

  it "should have a current_user" do
    expect( subject.current_user).to be
  end

  describe "#index" do

    it 'assigns a teams variable' do
      team
      team_2
      get 'index'
      expect(assigns(:teams)).to eq([team, team_2])
    end

    it 'renders index variable' do
      get 'index'
      expect(response).to render_template(:index)
    end
  end

  describe "#new" do

    it 'renders the new template' do
      get 'new'
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "with valid params" do

      def valid_request 
        post :create, {team: attributes_for(:team)}
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end

      it 'redirects to team page' do
        valid_request
        expect(response).to redirect_to(Team.last)
      end

      it 'creates a record in the DB' do
        expect(Team.count).to be(0)
        valid_request
        expect(Team.count).to be(1)
      end
    end

    context "with invalid params" do
      def invalid_request
        post :create, {team: {name: nil}}
      end

      it 'renders the new template' do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "sets a flash message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#show" do
    render_views
    def valid_request(format='html')
      get :show, {id: team.id, format:format}
    end

    it 'assigns the team to the variable' do
      valid_request
      expect(assigns(:team)).to eq(team)
    end

    it 'renders correct JSON' do
      valid_request('json')
      json = JSON.parse(response.body)
      expect(json["team"]["id"]).to eq(team.id)
    end
  end

  describe "#edit" do
    def valid_request
      get :edit, {id: team.id}
    end

    it 'assigns the team to the variable' do
      valid_request
      expect(assigns(:team)).to eq(team)
    end

    it 'renders the edit template' do
      valid_request
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    def update_request(params = {name: team.name})
      patch :update, id: team, team: params
    end
    context "with valid params" do

      it 'changes the team name if different' do
        update_request({name: "James' Homies"})
        team.reload
        expect(team.name).to eq("James' Homies")
      end

      it 'redirects to the team page' do
        update_request
        expect(response).to redirect_to(team)
      end

      it "sets a flash message" do
        update_request
        expect(flash[:notice]).to be
      end
    end

    context "with invalid params" do
      it 'does not change the team name' do
        name = team.name
        update_request({name: nil})
        team.reload
        expect(team.name).to eq(name)
      end

      it 'renders the edit template' do
        update_request({name: nil})
        expect(response).to render_template(:edit)
      end

      it 'sets a flash message' do
        update_request({name: nil})
        expect(flash[:alert]).to be
      end
    end
  end

end
