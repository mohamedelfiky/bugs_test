require 'rails_helper'

describe BugsWorker do
  it 'enqueues a bug' do
    BugsWorker.perform_async('fake_key')

    expect(BugsWorker).to have_enqueued_job('fake_key')
  end
end
