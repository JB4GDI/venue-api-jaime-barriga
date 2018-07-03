# spec/requests/venues_spec.rb
require 'rails_helper'

RSpec.describe 'venues API' do
  # Initialize the test data
  let!(:venueadmin) { create(:venueadmin) }
  let(:venueadmin_id) { venueadmin.id }
  
  let!(:venue) { create(:venue, venueadmin_id: venueadmin.id) }
  let(:venue_id) { venue.id }

  let!(:categorys) { create_list(:category, 20, venue_id: venue.id) }  
  let(:id) { categorys.first.id }


  # Test suite for GET /venueadmins/:venueadmin_id/venues/:venue_id/categorys
  describe 'GET /venueadmins/:venueadmin_id/venues/:venue_id/categorys' do
    before { get "/venueadmins/#{venueadmin_id}/venues/#{venue_id}/categorys" }

    context 'when venue exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all venue categories' do
        expect(json.size).to eq(20)
      end
    end

    context 'when venue does not exist' do
      let(:venue_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Venue/)
      end
    end
  end

  # Test suite for GET /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:id
  describe 'GET /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:id' do
    before { get "/venueadmins/#{venueadmin_id}/venues/#{venue_id}/categorys/#{id}" }

    context 'when venue category exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the category' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when venue category does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Category/)
      end
    end
  end

  # Test suite for PUT /venueadmins/:venueadmin_id/venues/:venue_id/categorys
  describe 'POST /venueadmins/:venueadmin_id/venues/:venue_id/categorys' do
    let(:valid_attributes) { { name: 'Planning'} }

    context 'when request attributes are valid' do
      before { post "/venueadmins/#{venueadmin_id}/venues/#{venue_id}/categorys", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/venueadmins/#{venueadmin_id}/venues/#{venue_id}/categorys", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:id
  describe 'PUT /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:id' do
    let(:valid_attributes) { { name: 'Profile' } }

    before { put "/venueadmins/#{venueadmin_id}/venues/#{venue_id}/categorys/#{id}", params: valid_attributes }

    context 'when category exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the category' do
        updated_category = Category.find(id)
        expect(updated_category.name).to match(/Profile/)
      end
    end

    context 'when the category does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Category/)
      end
    end
  end

  # Test suite for DELETE /venueadmins/:id
  describe 'DELETE /venueadmins/:id' do
    before { delete "/venueadmins/#{venueadmin_id}/venues/#{venue_id}/categorys/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end