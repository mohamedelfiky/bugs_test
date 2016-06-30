class State < ActiveRecord::Base
  belongs_to :bug

  validates :memory, :storage, :device, :os, presence: true
  validates :memory, :storage, numericality: true
end
