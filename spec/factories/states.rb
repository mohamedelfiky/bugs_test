FactoryGirl.define do
  factory :state do
    sequence(:device) { |n| "device#{ n }" }
    sequence(:os) { |n| "os#{ n }" }
    memory 1024
    storage 20_480
  end
end
