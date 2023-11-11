require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { User.create(name: 'Bello', postcounter: 0) }

  describe 'GET /index' do
    it 'renders index template' do
      get '/users'
      expect(response.status).to eq(200)
      expect(response).to render_template('index')
      # expect(response.body).to include('List of all users')
    end
  end

  describe 'GET /show' do
    it 'renders show template' do
      get "/users/#{user.id}"
      expect(response.status).to eq(200)
      expect(response).to render_template('users/show')
      # expect(response.body).to include('Show details of a particular user')
    end
  end
end
