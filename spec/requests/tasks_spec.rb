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
      expect(task_json['priority']).to eq @task.priority
      expect(task_json['title']).to eq @task.title
      expect(task_json['title']).to eq @task.title
      expect(task_json['description']).to eq @task.description
    end
  end

end
