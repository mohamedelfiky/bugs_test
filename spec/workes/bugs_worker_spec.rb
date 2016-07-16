require 'rails_helper'

RSpec.describe BugsWorker do
  let(:bug) do
    b = build(:bug)
    b.increment_bugs_count
    b
  end

  describe '#work' do
    it 'saves a bug to db' do
      redis_key = "#{ bug.application_token }_#{ bug.number }"
      Redis.current.set(redis_key, bug.json_attributes)
      BugsWorker.new.work(redis_key)
      expect(Bug.last.number).to eq(bug.number)
    end
  end
end
