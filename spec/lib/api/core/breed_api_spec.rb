# frozen_string_literal: true

require "rails_helper"

describe Api::Core::BreedApi do
  let(:dog_api_response) do
    VCR.use_cassette("fixtures/valid_dog_data") { JSON.parse(Api::Core::BreedApi.new("https://dog.ceo").get("api/breed/boxer/images/random").body) }
  end
  let(:invalid_dog_api_response) do
    VCR.use_cassette("fixtures/invalid_dog_data") { JSON.parse(Api::Core::BreedApi.new("https://dog.ceo").get("api/test/boxer/images/random").body) }
  end

  it "can fetch & parse dog data" do
    expect(dog_api_response).to be_kind_of(Hash)
    expect(dog_api_response).to have_key("message")
    expect(dog_api_response).to have_key("status")
  end

  it "can get dog data successfully" do
    expect(dog_api_response["status"]).to eq("success")
  end

  it "can fetch & parse invalid dog data" do
    expect(invalid_dog_api_response).to be_kind_of(Hash)
    expect(invalid_dog_api_response).to have_key("message")
    expect(invalid_dog_api_response).to have_key("status")
  end

  it "can get error status for non existing breed" do
    expect(invalid_dog_api_response["status"]).to eq("error")
  end

  it "can get not found status code for non existing breed" do
    expect(invalid_dog_api_response["code"]).to eq(404)
  end
end
