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
    it 'should return the projects associated with a user' do
      @user = @users.first
      @user.projects << FactoryGirl.create_list(:project, 5)
      get "/users/#{@user.id}/projects", nil, {'authorization' => "Token token=#{@users.first.token}"}

      expect(response).to be_success
      projects_json = JSON.parse(response.body)
      expect(projects_json.length).to eq 5
    end
  end

  describe '#show' do
    it 'should retrieve a single project by id and return json' do
    @project = @projects.first
    get "/projects/#{@project.id}", nil, {'authorization' => "Token token=#{@users.first.token}"}
    expect(response).to be_success
    project = JSON.parse(response.body)
    expect(project['project_title']).to eq @project.project_title
    end
  end

  describe '#create' do
    it 'should create a new project associated with a user' do
    post "/users/#{@users.first.id}/projects",
    { project: { project_title: 'Inceptos Ullamcorper', description: 'Nulla vitae elit libero, a pharetra augue. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.', start_date: '2014-06-13', due_date: '2014-08-20', completion_date: '2014-07-21', completed: true, visible: false }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'authorization' => "Token token=#{@users.first.token}" }
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON
      project = JSON.parse(response.body)
      expect(project['project_title']).to eq 'Inceptos Ullamcorper'
    end
  end

  describe '#update' do
    it 'should update a project' do
      @project = @projects.first
      patch "/projects/#{@project.id}",
      { project: { project_title: 'Euismod Lorem'}
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'authorization' => "Token token=#{@users.first.token}" }
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON
      project = JSON.parse(response.body)
      expect(project['project_title']).to eq 'Euismod Lorem'
    end
  end

  describe '#destroy' do
    it 'should destroy a project' do
      @project = @projects.first
      delete "/projects/#{@project.id}", nil, {'authorization' => "Token token=#{@users.first.token}"}
      expect(response.status).to eq 204
    end
  end




end
