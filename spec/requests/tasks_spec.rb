require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

describe 'Tasks requests' do

  before(:all) do
    DatabaseCleaner.clean
    @users = FactoryGirl.create_list(:user, 5)
    @projects = FactoryGirl.create_list(:project, 10)
    @project = @projects.first
    @project.tasks << FactoryGirl.create_list(:task, 5)
    @task = @project.tasks.first
  end

  describe '#index' do
    it 'gets all the tasks for a project' do
      get "/projects/#{@project.id}/tasks"
      expect(response).to be_success
      tasks_json = JSON.parse(response.body)
      expect(tasks_json.length).to eq 5
    end
  end

  describe '#show' do
    it 'should retrieve a single task by id and return json' do
      get "/tasks/#{@task.id}"
      expect(response).to be_success
      task_json = JSON.parse(response.body)
      expect(task_json['id']).to eq @task.id
      expect(task_json['completed']).to eq @task.completed
      expect(task_json['priority']).to eq @task.priority
      expect(task_json['title']).to eq @task.title
      expect(task_json['description']).to eq @task.description
    end
  end

  describe '#create' do
    it 'should create a new task associated with a project' do
      post "/projects/#{@project.id}/tasks",
      { task: { due_date: '2015-12-12', completed: false, priority: 5, title: 'task title', description: 'task description' }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON
      task_json = JSON.parse(response.body)
      expect(task_json['id']).to eq @project.tasks.last.id
      expect(task_json['completed']).to eq false
      expect(task_json['priority']).to eq 5
      expect(task_json['title']).to eq 'task title'
      expect(task_json['description']).to eq 'task description'
    end
  end

  describe '#update' do
    it 'should update a project' do
      patch "/tasks/#{@task.id}",
      { task: { title: 'new title' } }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON
      task_json = JSON.parse(response.body)
      expect(task_json['title']).to eq 'new title'
      expect(task_json['id']).to eq @task.id
    end
  end

  describe '#destroy' do
    it 'should destroy a task' do
      tasks_count = @project.tasks.length
      delete "/tasks/#{@task.id}"
      expect(response.status).to eq 204
      expect(Task.all).not_to include @task
    end
  end

end
