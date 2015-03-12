require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

describe 'Projects Requests' do
  before(:all) do
    DatabaseCleaner.clean
    @users = FactoryGirl.create_list(:user, 5)
    @projects = FactoryGirl.create_list(:project, 10)
  end

  describe '#index' do
    it 'gets all the projects for a user' do
      get "/users/#{@users.first.id}/projects"
      expect(response).to be_success
    end
  end

  describe '#show' do
    it 'should retrieve a single project by id and return json' do
    @project = @projects.first
    get "/projects/#{@project.id}"
    expect(response).to be_success
    project = JSON.parse(response.body)
    expect(project['project_title']).to eq @project.project_title
    end
  end




end
