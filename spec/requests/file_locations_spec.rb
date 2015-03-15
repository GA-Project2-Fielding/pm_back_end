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
      file_locations_json = JSON.parse(response.body)

      expect(response).to be_success
      expect(file_locations_json.length).to eq 2
    end
  end

  describe '#show' do
    it 'should retrieve a single file_location by id and return json' do
      get "/file_locations/#{@file_location.id}", nil, {authorization: "Token token=#{@user.token}"}
      file_location_json = JSON.parse(response.body)

      expect(response).to be_success
      expect(file_location_json['id']).to eq @file_location.id
      expect(file_location_json['name']).to eq @file_location.name
      expect(file_location_json['url']).to eq @file_location.url
      expect(file_location_json['task']['id']).to eq @file_location.task_id
    end
  end

  describe '#create' do
    it 'should create a new file_location associated with a task' do
      post_object =
      {
        file_location:
        {
          name: Faker::Lorem.word,
          url: Faker::Internet.url
        }
      }
      post "/tasks/#{@task.id}/file_locations", post_object.to_json,
      {
        accept: Mime::JSON, 'Content-Type' => Mime::JSON.to_s, authorization: "Token token=#{@user.token}"
      }
      file_location_json = JSON.parse(response.body)

      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON
      expect(file_location_json['id']).to eq @file_locations.last.id
      expect(file_location_json['name']).to eq post_object[:file_location][:name]
      expect(file_location_json['url']).to eq post_object[:file_location][:url]
    end
  end

  describe '#destroy' do
    it 'should destroy a file_location' do
      expect(FileLocation.all).to include @file_location
      delete "/file_locations/#{@file_location.id}", nil, { authorization: "Token token=#{@user.token}" }

      expect(response.status).to eq 204
      expect(FileLocation.all).not_to include @file_location
    end
  end

end
