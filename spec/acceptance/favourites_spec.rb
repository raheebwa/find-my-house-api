require 'acceptance_helper'

# rubocop:disable Metrics/BlockLength
resource 'Favourite', acceptance: true do
  let!(:user) { create(:user) }
  let!(:house) { create(:house) }
  let!(:favourite) { create(:favourite) }
  let!(:id) { favourite.id }
  let!(:user_id) { user.id }

  def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  before do
    header 'Authorization', encode_token({ user_id: user.id })
    header 'Content-Type', 'application/json'
  end

  get '/users/:user_id/favourites/' do
    example_request 'Listing favorites' do
      explanation 'List all your current favorites'
      expect(status).to eq 200
    end
  end

  post '/users/:user_id/favourites/' do
    route_summary 'This is used to create a new favourite'

    parameter house_id: 'The id of the house you want to fav'
    example_request 'Fav a house' do
      explanation 'Users can create new favourites' do
        expect(status).to eq 204
      end
    end
  end

  delete '/users/:user_id/favourites/:id' do
    route_summary 'Remove a favourite'

    example_request 'Delete a fav' do
      explanation 'Users can delete a fav' do
        expect(status).to eq 204
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
