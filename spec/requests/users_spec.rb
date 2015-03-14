require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

describe 'Users Requests' do
  before(:all) do
    DatabaseCleaner.clean
    @user = FactoryGirl.build(:user)
  end

  describe '#create' do
    it 'should create a new user' do
    post "/users",
    { user: { user_name: 'Justo', email: 'justo@me.com', first_name: 'Mollis', last_name: 'Fermentum', password: 'password', password_confirmation: 'password', image_url: 'http://imgur.com/23893y', description: 'Donec id elit non mi porta gravida at eget metus.'}
    }.to_json,
    { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, }
    expect(response).to be_success
    expect(response.content_type).to be Mime::JSON
    token = JSON.parse(response.body)
    expect(token['token'].length).to be(32)
    end
  end
end
