require 'rails_helper'

RSpec.describe 'Comment API' do
  # Initialize the test data
  let!(:post) { create(:post) }
  let!(:comments) { create_list(:comment, 20, post_id: post.id) }
  let(:post_id) { post.id }
  let(:id) { comments.first.id }

  # Test suite for GET /posts/:post_id/comments
  describe 'GET /api/v1/posts/:post_id/comments' do
    before { get "/api/v1/posts/#{post_id}/comments" }

    context 'when todo exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

    end

    
  end

  # Test suite for GET /posts/:posts_id/comments/:id
  describe 'GET /api/v1/posts/:post_id/comments/:id' do
    before { get "/api/v1/posts/#{post_id}/comments/#{id}" }

    context 'when todo item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json["data"]['id']).to eq(id)
      end
    end

    context 'when post comment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json["status"]).to match("Error")
      end
    end
  end

  # Test suite for PUT /posts/:post_id/comments
  describe 'POST /posts/:post_id/comments' do
   let(:valid_attributes) { { message: 'Hello' } }

    context 'when request attributes are valid' do
      before { post "/api/v1/posts/#{post_id}/comments", params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

   
  end

  # Test suite for PUT /posts/:post_id/comments/:id
  describe 'PUT /posts/:post_id/comments/:id' do
    #let(:valid_attributes) { { message: 'Mozart' } }

    before { put "/api/v1/posts/#{post_id}/comments/#{id}", params: { message: 'Mozart' } }

    context 'when comment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the comment' do
        updated_item = Comment.find(id)
        expect(updated_item.message).to match(/Mozart/)
      end
    end

    context 'when the comment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json["status"]).to match("Error")
      end
    end
  end

  
  describe 'DELETE /api/v1/posts/:post_id/comments/:id' do
    before { delete "/api/v1/posts/#{post_id}/comments/#{id}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end