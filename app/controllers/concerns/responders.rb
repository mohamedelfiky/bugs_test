# Provides respond formatting methods
module Responders
  extend ActiveSupport::Concern

  def respond_with(error_message)
    render(
      json: { errors: error_message },
      status: :unprocessable_entity
    )
  end
end
