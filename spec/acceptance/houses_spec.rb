require 'acceptance_helper'

# rubocop:disable Metrics/BlockLength

resource 'Service', acceptance: true do
  let!(:user) { create(:user) }
  let!(:house) { create(:house) }

  def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  before do
    header 'Authorization', encode_token({ user_id: user.id })
    header 'Content-Type', 'application/json'
  end
  get '/houses' do
    example_request 'Listing houses' do
      explanation 'List all the houses'
      expect(status).to eq 200
    end
  end

  get '/houses/:house_id' do
    example_request 'See a house in detail' do
      explanation 'See all the details of a specific house' do
        expect(status).to eq 200
      end
    end
  end

  post '/houses/' do
    route_summary 'This is used to create a new house'

    parameter title: 'Service title'
    parameter description: 'In depth description of the house'
    parameter image_url: 'An image to ilustrate the house'
    parameter price: 'The monetary value of the house'

    example_request 'Create a house' do
      explanation 'Admin users can create new houses' do
        expect(status).to eq 204
      end
    end
  end

  put '/houses/:id' do
    route_summary 'This is used to update a house'

    parameter title: 'Update the house title'
    parameter description: 'Update the in depth description of the house'
    parameter image_url: 'Update the image to ilustrate the house'
    parameter price: 'Update the monetary value of the house'

    example_request 'Update a house' do
      explanation 'Admin users can update the fields of a house' do
        expect(status).to eq 204
      end
    end
  end

  delete '/houses/:id' do
    route_summary 'This is used to deleta a house entry'

    example_request 'Delete a house' do
      explanation 'Admin users can delete a house' do
        expect(status).to eq 204
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
