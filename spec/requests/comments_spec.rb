require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

describe 'Comments Requests' do
  before(:all) do
    DatabaseCleaner.clean
    @users = FactoryGirl.create_list(:user, 5)
    @tasks = FactoryGirl.create_list(:task, 10)
    @comments = FactoryGirl.create_list(:comment, 20)
  end

  describe '#index' do
    it 'should return the comments associated with a task' do
      get "/tasks/#{@tasks.first.id}/comments"
      expect(response).to be_success
    end
  end

  describe '#show' do
    it 'should retrieve a single comment by id and return json' do
      @comment = @comments.first
      get "/comments/#{@comment.id}"
      expect(response).to be_success
      comment = JSON.parse(response.body)
      expect(comment['body']).to eq @comment.body
    end
  end

end

