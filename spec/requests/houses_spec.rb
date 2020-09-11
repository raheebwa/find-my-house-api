require 'rails_helper'

RSpec.describe "/houses", type: :request do
  let(:valid_attributes) {
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      House.create! valid_attributes
      get houses_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      house = House.create! valid_attributes
      get house_url(house), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new House" do
        expect {
          post houses_url,
               params: { house: valid_attributes }, headers: valid_headers, as: :json
        }.to change(House, :count).by(1)
      end

      it "renders a JSON response with the new house" do
        post houses_url,
             params: { house: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new House" do
        expect {
          post houses_url,
               params: { house: invalid_attributes }, as: :json
        }.to change(House, :count).by(0)
      end

      it "renders a JSON response with errors for the new house" do
        post houses_url,
             params: { house: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested house" do
        house = House.create! valid_attributes
        patch house_url(house),
              params: { house: invalid_attributes }, headers: valid_headers, as: :json
        house.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the house" do
        house = House.create! valid_attributes
        patch house_url(house),
              params: { house: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the house" do
        house = House.create! valid_attributes
        patch house_url(house),
              params: { house: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested house" do
      house = House.create! valid_attributes
      expect {
        delete house_url(house), headers: valid_headers, as: :json
      }.to change(House, :count).by(-1)
    end
  end
end
