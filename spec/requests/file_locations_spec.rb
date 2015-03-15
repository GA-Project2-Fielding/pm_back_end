require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

describe 'FileLocations requests' do
  before(:all) do
    DatabaseCleaner.clean
    @user = FactoryGirl.create(:user)
    @user.projects << FactoryGirl.create_list(:project, 2)
    @project = @user.projects.first
    @project.tasks << FactoryGirl.create_list(:task, 2)
    @task = @project.tasks.first
    @task.file_locations << FactoryGirl.create_list(:file_location, 2)
    @file_locations = @task.file_locations
    @file_location = @file_locations.first
  end

  describe '#index' do
    it 'gets all the file_locations for a task' do
      get "/tasks/#{@task.id}/file_locations", nil, {'authorization' => "Token token=#{@user.token}"}
      expect(response).to be_success
      file_locations_json = JSON.parse(response.body)
      expect(file_locations_json.length).to eq 2
    end
  end
end
