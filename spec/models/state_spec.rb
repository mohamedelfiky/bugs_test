require 'rails_helper'

RSpec.describe State, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:bug) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:memory) }
    it { is_expected.to validate_presence_of(:storage) }
    it { is_expected.to validate_presence_of(:device) }
    it { is_expected.to validate_presence_of(:os) }
    it { is_expected.to validate_numericality_of(:memory) }
    it { is_expected.to validate_numericality_of(:storage) }
  end
end
