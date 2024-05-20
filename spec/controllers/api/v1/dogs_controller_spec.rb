# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DogsController, type: :controller do
  describe 'GET #search_breed' do
    context 'with valid breed parameter' do
      let(:valid_breed) { 'labrador' }
      let(:response_body) { { "success" => true, "result" => 'https://example.com/labrador.jpg' }.as_json }

      before do
        allow(Api::V1::Dogs::GetBreedImage).to receive(:call).with(valid_breed).and_return(response_body)
        get :search_breed, params: { dogs: { breed: valid_breed } }
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the image URL in the response body' do
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end

    context 'not valid parameter' do
      let(:valid_breed) { 'labrador' }
      let(:response_body) do
        { "success" => false, "errors" => "Breed not found (master breed does not exist)", "result" => nil }.as_json
      end

      before do
        allow(Api::V1::Dogs::GetBreedImage).to receive(:call).with(valid_breed).and_return(response_body)
        get :search_breed, params: { dogs: { breed: valid_breed } }
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the image URL in the response body' do
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end

    context 'with missing breed parameter' do
      it 'returns a not found response' do
        get :search_breed, params: {}
        expect(JSON.parse(response.body)["errors"]).to eq("Oops! Something went wrong. Please try again later.")
      end
    end
  end
end
