class ApplicationController < ActionController::API
  include Responders
  include ErrorHandlers

  # for using jbuilder with rails-api
  include ActionController::ImplicitRender
end
