require 'api_constraints'

v1_api = ApiConstraints.new(version: 1, default: true)

Rails.application.routes.draw do
  defaults(format: :json) do
    scope module: :v1, constraints: v1_api do
      resources :bugs, except:  %i(new edit update destroy), param: :number do
        get :count, on: :collection
      end
    end
  end
end
