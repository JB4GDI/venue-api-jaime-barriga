# spec/requests/venueadmins_spec.rb
require 'rails_helper'

RSpec.describe 'VenueAdmins API', type: :request do
  # initialize test data 
  let!(:venueadmins) { create_list(:venueadmin, 10) }
  let(:venueadmin_id) { venueadmins.first.id }

  # Test suite for GET /venueadmins
  describe 'GET /venueadmins' do
    # make HTTP get request before each example
    before { get '/venueadmins' }

    it 'returns venueadmins' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /venueadmins/:id
  describe 'GET /venueadmins/:id' do
    before { get "/venueadmins/#{venueadmin_id}" }

    context 'when the record exists' do
      it 'returns the venueadmin' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(venueadmin_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:venueadmin_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Venueadmin/)
      end
    end
  end

  # Test suite for POST /venueadmins
  describe 'POST /venueadmins' do
    # valid payload
    let(:valid_attributes) { { name: 'John Venueman', email: 'John@Venuman.com' } }

    context 'when the request is valid' do
      before { post '/venueadmins', params: valid_attributes }

      it 'creates a venueadmin' do
        expect(json['name']).to eq('John Venueman')
        expect(json['email']).to eq('John@Venuman.com')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/venueadmins', params: { name: 'No Emailman' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Email can't be blank/)
      end
    end

    context 'when the request is invalid' do
      before { post '/venueadmins', params: { email: 'No@Nameman.com' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end

  end

  # Test suite for PUT /venueadmins/:id
  describe 'PUT /venueadmins/:id' do
    let(:valid_attributes) { { name: 'Legal Namechangeman' } }

    context 'when the record exists' do
      before { put "/venueadmins/#{venueadmin_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /venueadmins/:id
  describe 'DELETE /venueadmins/:id' do
    before { delete "/venueadmins/#{venueadmin_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end