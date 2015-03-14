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
      @task = @tasks.first
      @task.comments << FactoryGirl.create_list(:comment, 5)
      get "/tasks/#{@task.id}/comments", nil, {'authorization' => "Token token=#{@users.first.token}"}

      expect(response).to be_success
      comments_json = JSON.parse(response.body)
      expect(comments_json.length).to eq 5
    end
  end

  describe '#show' do
    it 'should retrieve a single comment by id and return json' do
      @comment = @comments.first
      get "/comments/#{@comment.id}", nil, {'authorization' => "Token token=#{@users.first.token}"}
      expect(response).to be_success
      comment = JSON.parse(response.body)
      expect(comment['body']).to eq @comment.body
    end
  end

  describe '#create' do
    it 'should create a new comment associated with a task' do
    post "/tasks/#{@tasks.first.id}/comments",
    { comment: { body: 'Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.', user_id: @users.first.id }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'authorization' => "Token token=#{@users.first.token}" }
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON
      comment = JSON.parse(response.body)
      expect(comment['body']).to eq 'Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.'

    end

  end

  describe '#update' do
    it 'should update a comment' do
      @comment = @comments.first
      patch "/comments/#{@comment.id}",
      { comment: { body: 'Donec sed odio dui.' }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'authorization' => "Token token=#{@users.first.token}" }
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON
      comment = JSON.parse(response.body)
      expect(comment['body']).to eq 'Donec sed odio dui.'
    end
  end

  describe '#destroy' do
    it 'should destroy a comment' do
      @comment = @comments.first
      delete "/comments/#{@comment.id}", nil, {'authorization' => "Token token=#{@users.first.token}"}
      expect(response.status).to eq 204
      expect(Comment.all).not_to include @comment
    end
  end



end

