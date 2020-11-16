require 'rails_helper'

RSpec.describe 'Post API', type: :request do
  # initialize test data
  let!(:posts) { create_list(:post, 10) }
  let(:post_id) { posts.first.id }

  # Test suite for GET /api/v1/posts
  describe 'GET /api/v1/posts' do
    # make HTTP get request before each example
    before { get '/api/v1/posts' }

    it 'returns posts' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
     
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/posts/:id
  describe 'GET /api/v1/posts/:id' do
    before { get "/api/v1/posts/#{post_id}" }

    context 'when the record exists' do
      it 'returns the post' do
        expect(json).not_to be_empty
        expect(json["data"]["id"]).to eq(post_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:post_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json["status"]).to match("Error")
          
      end
    end
  end

  # Test suite for POST /posts
  describe 'POST /api/v1/posts' do
    # valid payload
    let(:valid_attributes) { { title: 'Learn Elm', content: 'when the request is vali' } }

    context 'when the request is valid' do
      before { post '/api/v1/posts', params: valid_attributes }

      it 'creates a post' do
        expect(json["data"]["title"]).to eq('Learn Elm')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/posts', params: { title: 'Fooba mer' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json["status"])
          .to match("Error")
      end
    end
  end

  # Test suite for PUT /api/v1/posts/:id
  describe 'PUT /api/v1/posts/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/api/v1/posts/#{post_id}", params: valid_attributes }

      it 'updates the record' do
        expect(json["data"]["title"]).to eq('Shopping')
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(200)
      end
    end
  end

 
end