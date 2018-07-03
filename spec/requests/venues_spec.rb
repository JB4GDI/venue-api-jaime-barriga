# spec/requests/venues_spec.rb
require 'rails_helper'

RSpec.describe 'venues API' do
  # Initialize the test data
  let!(:venueadmin) { create(:venueadmin) }
  let!(:venues) { create_list(:venue, 20, venueadmin_id: venueadmin.id) }
  let(:venueadmin_id) { venueadmin.id }
  let(:id) { venues.first.id }

  # Test suite for GET /venueadmins/:venueadmin_id/venues
  describe 'GET /venueadmins/:venueadmin_id/venues' do
    before { get "/venueadmins/#{venueadmin_id}/venues" }

    context 'when venueadmin exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all venueadmin venues' do
        expect(json.size).to eq(20)
      end
    end

    context 'when venueadmin does not exist' do
      let(:venueadmin_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Venueadmin/)
      end
    end
  end

  # Test suite for GET /venueadmins/:venueadmin_id/venues/:id
  describe 'GET /venueadmins/:venueadmin_id/venues/:id' do
    before { get "/venueadmins/#{venueadmin_id}/venues/#{id}" }

    context 'when venueadmin venue exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the venue' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when venueadmin venue does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Venue/)
      end
    end
  end

  # Test suite for PUT /venueadmins/:venueadmin_id/venues
  describe 'POST /venueadmins/:venueadmin_id/venues' do
    let(:valid_attributes) { { name: 'Venueplace'} }

    context 'when request attributes are valid' do
      before { post "/venueadmins/#{venueadmin_id}/venues", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/venueadmins/#{venueadmin_id}/venues", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /venueadmins/:venueadmin_id/venues/:id
  describe 'PUT /venueadmins/:venueadmin_id/venues/:id' do
    let(:valid_attributes) { { name: 'Coolvenue' } }

    before { put "/venueadmins/#{venueadmin_id}/venues/#{id}", params: valid_attributes }

    context 'when venue exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the venue' do
        updated_venue = Venue.find(id)
        expect(updated_venue.name).to match(/Coolvenue/)
      end
    end

    context 'when the venue does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Venue/)
      end
    end
  end

  # Test suite for DELETE /venueadmins/:id
  describe 'DELETE /venueadmins/:id' do
    before { delete "/venueadmins/#{venueadmin_id}/venues/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end