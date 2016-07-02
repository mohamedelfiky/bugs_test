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

  describe 'Bugs count_by_application' do
    let(:bug) do
      b = build(:bug)
      b.increment_bugs_count
      b.save!
      b
    end
    let(:bugs_count) { Bug.where(application_token: bug.application_token).count }

    it 'returns the correct count from db' do
      Redis.current.del("#{ bug.application_token }_bugs_count")
      expect(bugs_count).to eq(Bug.count_by_application(bug.application_token))
    end

    it 'returns the correct count from redis' do
      expect(bugs_count).to eq(Bug.count_by_application(bug.application_token).to_i)
    end
  end

  describe 'Bugs filter' do
    let(:bug) do
      b = build(:bug)
      b.increment_bugs_count
      b
    end

    it 'returns the correct bug from db' do
      bug.save!
      expect(bug.json_attributes).to eq(Bug.filter(bug.number, bug.application_token).json_attributes)
    end

    it 'returns the correct bug from redis' do
      Redis.current.set("#{ bug.application_token }_#{ bug.number }", bug.json_attributes)
      expect(bug.json_attributes).to eq(Bug.filter(bug.number, bug.application_token).json_attributes)
    end
  end
end
