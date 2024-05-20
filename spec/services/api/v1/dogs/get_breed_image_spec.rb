# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Dogs::GetBreedImage, type: :service do
  describe '.call' do
    let(:breed) { 'labrador' }
    let(:error_tracker) { instance_double(ErrorTracker) }

    context 'when API call is successful' do
      let(:response_body) { { "message" => "https://images.dog.ceo/breeds/labrador/n02099712_1234.jpg", "status" => 200 } }
      let(:response_double) { instance_double(Faraday::Response, body: response_body.to_json, status: 200) }

      before do
        allow(Api::Core::BreedApi).to receive(:new).and_return(response_double)
        allow(error_tracker).to receive(:add_error)
        allow(error_tracker).to receive(:success).and_return(true)
        allow(error_tracker).to receive(:list_errors).and_return("")
      end

      it 'calls the process method and returns a service response' do
        allow(Api::V1::Dogs::GetBreedImage).to receive(:process).and_return(response_body)
        expect(ServiceResponseBuilder).to receive(:call).with(response_body, error_tracker).and_call_original

        described_class.call(breed, error_tracker)
      end
    end

    context 'when API call raises an error' do
      let(:error_message) { 'Error message' }
      let(:response_double) do
        instance_double(Faraday::Response, body: { "message" => error_message }.to_json, status: 404)
      end

      before do
        allow(Api::Core::BreedApi).to receive(:new).and_return(response_double)
        allow(error_tracker).to receive(:add_error)
        expect(error_tracker).to receive(:success).thrice.and_return(false)
        expect(error_tracker).to receive(:list_errors).and_return("Error 1")
      end

      it 'adds the error to error tracker and returns a service response' do
        expect(Api::V1::Dogs::GetBreedImage).to receive(:process).with(breed)
        expect(ServiceResponseBuilder).to receive(:call).with(nil, error_tracker).and_call_original

        described_class.call(breed, error_tracker)
      end
    end
  end

  describe '.process' do
    let(:breed) { 'labrador' }

    context 'when API call is successful' do
      let(:response_body) { { "message" => "https://images.dog.ceo/breeds/labrador/n02099712_1234.jpg", "status" => 200 } }
      let(:response_double) { instance_double(Faraday::Response, body: response_body.to_json, status: 200) }

      before do
        allow(Api::Core::BreedApi).to receive(:new).and_return(response_double)
      end

      it 'returns the parsed JSON response' do
        expect(Api::V1::Dogs::GetBreedImage).to receive(:process).with(breed).and_return(response_body)

        expect(described_class.send(:process, breed)).to eq(response_body)
      end
    end

    context 'when API call raises an error' do
      let(:error_message) { 'Error message' }
      let(:response_double) do
        instance_double(Faraday::Response, body: { "message" => error_message }.to_json, status: 404)
      end

      before do
        allow(Api::Core::BreedApi).to receive(:new).and_return(response_double)
      end

      it 'raises an error' do
        expect(Api::V1::Dogs::GetBreedImage).to receive(:process).with(breed).and_raise("Error 1")
        expect do
          described_class.send(:process, breed)
        end.to raise_error("Error 1")
      end
    end
  end
end
