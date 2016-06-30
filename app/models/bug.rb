class Bug < ActiveRecord::Base
  has_one :state, dependent: :destroy

  validates :application_token, :status, :priority, presence: :true
  validates :number, uniqueness: { scope: :application_token }
end
