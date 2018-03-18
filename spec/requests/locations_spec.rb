require 'rails_helper'

RSpec.describe 'Locations API' do
  # Initialize the test data
  let(:user) { create(:user) }
  let!(:cab) { create(:cab) }
  let!(:locations) { create_list(:location, 20, cab_id: cab.id) }
  let(:cab_id) { cab.id }
  let(:id) { locations.first.id }
  let(:headers) { valid_headers }


  # Test suite for GET /cabs/:cab_id/locations
  describe 'GET /cabs/:cab_id/locations' do
    before { get "/cabs/#{cab_id}/locations", params: {}, headers: headers }

    context 'when cab exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all cab locations' do
        expect(json.size).to eq(20)
      end
    end

    context 'when cab does not exist' do
      let(:cab_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Cab/)
      end
    end
  end

  # Test suite for GET /cabs/:cab_id/locations/:id
  describe 'GET /cabs/:cab_id/locations/:id' do
    before { get "/cabs/#{cab_id}/locations/#{id}", params: {}, headers: headers }

    context 'when cab location exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the location' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when cab location does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Location/)
      end
    end
  end

  # Test suite for PUT /cabs/:cab_id/locations
  describe 'POST /cabs/:cab_id/locations' do
    let(:valid_attributes) { { lon: 0, lat: 0 }.to_json }

    context 'when request attributes are valid' do
      before { post "/cabs/#{cab_id}/locations", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/cabs/#{cab_id}/locations", params: {  }, headers: headers }.to_json

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Lon can't be blank, Lat can't be blank/)
      end
    end
  end

  # Test suite for PUT /cabs/:cab_id/locations/:id
  describe 'PUT /cabs/:cab_id/locations/:id' do
    let(:valid_attributes) { { lat: 0.0654 }.to_json }

    before { put "/cabs/#{cab_id}/locations/#{id}", params: valid_attributes, headers: headers }

    context 'when location exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the location' do
        updated_location = Location.find(id)
        expect(updated_location.lat).to match(0.0654)
      end
    end

    context 'when the location does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Location/)
      end
    end
  end

  # Test suite for DELETE /cabs/:id
  describe 'DELETE /cabs/:id' do
    before { delete "/cabs/#{cab_id}/locations/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
