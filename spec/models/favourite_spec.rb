require 'rails_helper'
require 'acceptance_helper'

RSpec.describe Favourite, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:house) }
end
