require 'rails_helper'

RSpec.describe 'Cabs API', type: :request do
  # initialize test data
  let(:user) { create(:user) }

  let!(:cabs) { create_list(:cab, 10) }
  let(:cab_id) { cabs.first.id }

  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /cabs
  describe 'GET /cabs' do
    before { get '/cabs', params: {}, headers: headers }
    # make HTTP get request before each example

    it 'returns cabs' do
      # Note `json` is a custom helper to parse JSON responses
      # expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /cabs/:id
  describe 'GET /cabs/:id' do
   before { get '/cabs', params: {}, headers: headers }


    context 'when the record exists' do
      it 'returns the cab' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(cab_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:cab_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Cab/)
      end
    end
  end

  # Test suite for POST /cabs
  describe 'POST /cabs' do
    # valid payload
    let(:valid_attributes) do
     { state: 'free', name: 'Elon', city: 'Melbourne' }.to_json
    end

    context 'when the request is valid' do
      before { post '/cabs', params: valid_attributes, headers: headers }

      it 'creates a cab' do
        expect(json['name']).to eq('Elon')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { city: nil }.to_json }
      before { post '/cabs', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: City can't be blank/)
      end
    end
  end

  # Test suite for PUT /cabs/:id
  describe 'PUT /cabs/:id' do
    let(:valid_attributes) { { name: 'Elon' }.to_json }

    context 'when the record exists' do
      before { put "/cabs/#{cab_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /cabs/:id
  describe 'DELETE /cabs/:id' do
    before { delete "/cabs/#{cab_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
