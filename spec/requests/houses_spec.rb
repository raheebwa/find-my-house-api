# frozen_string_literal: true

require 'rails_helper'
require 'acceptance_helper'

def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
end

RSpec.describe '/houses', type: :request do
  let(:house) { build(:house) }
  let(:user) { build(:user) }


  let(:valid_attributes) do
    {
      name: house.name,
      description: house.description,
      image_url: house.image_url,
      price: house.price
    }
  end

  let(:invalid_attributes) do
    {
      age: 560,
      trey: 'idiot'
    }
  end

  let(:valid_headers) do
    {
      'Authorization' => encode_token({ user_id: user.id }),
      'Content-Type' => 'application/json'
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      House.create! valid_attributes
      get houses_url, headers: valid_headers, as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      house = House.create! valid_attributes
      get house_url(house), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new House' do
        expect do
          post houses_url,
               params: { house: valid_attributes }, headers: valid_headers, as: :json
        end.to change(House, :count).by(1)
      end

      it 'renders a JSON response with the new house' do
        post houses_url,
             params: { house: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new House' do
        expect do
          post houses_url,
               params: { house: invalid_attributes }, as: :json
        end.to change(House, :count).by(0)
      end

      it 'renders a JSON response with errors for the new house' do
        post houses_url,
             params: { house: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {title: "New House"}
      end

      it 'updates the requested house' do
        house = House.create! valid_attributes
        patch house_url(house),
              params: { house: invalid_attributes }, headers: valid_headers, as: :json
        house.reload
        expect(response).to have_http_status(:ok)
      end

      it 'renders a JSON response with the house' do
        house = House.create! valid_attributes
        patch house_url(house),
              params: { house: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    # context 'with invalid parameters' do
    #   it 'renders a JSON response with errors for the house' do
    #     house = House.create! invalid_attributes
    #     patch house_url(house),
    #           params: { house: invalid_attributes }, headers: valid_headers, as: :json
    #     expect(response).to have_http_status(:unprocessable_entity)
    #   end
    # end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested house' do
      house = House.create! valid_attributes
      expect do
        delete house_url(house), headers: valid_headers, as: :json
      end.to change(House, :count).by(-1)
    end
  end
end
