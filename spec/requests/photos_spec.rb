# spec/requests/venues_spec.rb
require 'rails_helper'

RSpec.describe 'venues API' do
  # Initialize the test data
  let!(:venueadmin) { create(:venueadmin) }
  let(:venueadmin_id) { venueadmin.id }
  
  let!(:venue) { create(:venue, venueadmin_id: venueadmin.id) }
  let(:venue_id) { venue.id }

  let!(:category) { create(:category, venue_id: venue.id) }  
  let(:category_id) { category.id }

  let!(:photos) { create_list(:photo, 20, category_id: category.id) }  
  let(:id) { photos.first.id }
  
  # Test suite for GET /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:category_id/photos
  describe 'GET /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:category_id/photos' do
    before { get "/venueadmins/#{venueadmin_id}/venues/#{venue_id}/categorys/#{category_id}/photos" }

    context 'when category exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all category photos' do
        expect(json.size).to eq(20)
      end
    end

    context 'when category does not exist' do
      let(:category_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Category/)
      end
    end
  end

  # Test suite for GET /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:category_id/photos/:id
  describe 'GET /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:category_id/photos/:id' do
    before { get "/venueadmins/#{venueadmin_id}/venues/#{venue_id}/categorys/#{category_id}/photos/#{id}" }

    context 'when category photo exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the photo' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when category photo does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Photo/)
      end
    end
  end

  # Test suite for PUT /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:category_id/photos
  describe 'POST /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:category_id/photos' do
    let(:valid_attributes) { { filename: 'DCM_3023.jpg', caption: '', rank: 1} }

    context 'when request attributes are valid' do
      before { post "/venueadmins/#{venueadmin_id}/venues/#{venue_id}/categorys/#{category_id}/photos", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/venueadmins/#{venueadmin_id}/venues/#{venue_id}/categorys/#{category_id}/photos", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Filename can't be blank, Rank can't be blank/)
      end
    end

    context 'when an invalid request' do
      before { post "/venueadmins/#{venueadmin_id}/venues/#{venue_id}/categorys/#{category_id}/photos", params: { filename: 'norank.jpg' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Rank can't be blank/)
      end
    end

    context 'when an invalid request' do
      before { post "/venueadmins/#{venueadmin_id}/venues/#{venue_id}/categorys/#{category_id}/photos", params: { rank:0 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Filename can't be blank/)
      end
    end
  end

  # Test suite for PUT /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:category_id/photos/:id
  describe 'PUT /venueadmins/:venueadmin_id/venues/:venue_id/categorys/:category_id/photos/:id' do
    let(:valid_attributes) { { filename: 'realfilename', caption: '', rank: 1} }

    before { put "/venueadmins/#{venueadmin_id}/venues/#{venue_id}/categorys/#{category_id}/photos/#{id}", params: valid_attributes }

    context 'when photo exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the photo' do
        updated_photo = Photo.find(id)
        expect(updated_photo.filename).to match(/realfilename/)
      end
    end

    context 'when the photo does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Photo/)
      end
    end
  end

  # Test suite for DELETE /venueadmins/:id
  describe 'DELETE /venueadmins/:id' do
    before { delete "/venueadmins/#{venueadmin_id}/venues/#{venue_id}/categorys/#{category_id}/photos/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end