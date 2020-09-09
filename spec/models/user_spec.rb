require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:favourites).dependent(:destroy) }
  it { should have_many(:houses).through(:favourites) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }
end
