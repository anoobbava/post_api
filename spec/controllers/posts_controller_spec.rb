require 'pry'
require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before(:all) do
    @post = FactoryBot.create(:post)
  end

  it 'render to /posts' do
    get :index
    json = JSON.parse(response.body)
    expect(json).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it 'GET /posts/:id' do
    get :show, params: { id: @post.id }
    json = JSON.parse(response.body)
    expect(json).not_to be_empty
    expect(json['id']).to eq(@post.id)
    expect(response).to have_http_status(200)
  end

  it 'GET /posts/:id Invalid id' do
    get :show, params: { id: 'x' }
    expect(response).to have_http_status(404)
    expect(response.body).to match(/Couldn't find Post/)
  end


  it 'POST /posts' do
    post :create, params: { title: 'Learn Elm', url: 'www.example.com' }
    json = JSON.parse(response.body)
    expect(json['title']).to eq('Learn Elm')
    expect(json['url']).to eq('www.example.com')
  end

  it 'POST /posts invalid' do
    post :create, params: { title: 'Learn Elm' }
    expect(response).to have_http_status(422)
    expect(response.body)
          .to match("{\"message\":\"Validation failed: Url can't be blank\"}")
  end

  it 'PUT UPDATE' do
    put :update, params: { id: @post.id, title: 'Awesome' }
    expect(response).to have_http_status(204)
  end

  it ' delete' do
    delete :destroy, params: { id: @post.id }
    expect(response).to have_http_status(204)
  end
end
