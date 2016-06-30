require 'rails_helper'

RSpec.describe Bug, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:state) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:application_token) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:priority) }
    it { is_expected.to validate_uniqueness_of(:number).scoped_to(:application_token) }
  end
end
