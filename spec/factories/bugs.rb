FactoryGirl.define do
  factory :bug do
    application_token '1236587'
    status 'new_bug'
    priority 'critical'
    state { build(:state) }
  end
end
