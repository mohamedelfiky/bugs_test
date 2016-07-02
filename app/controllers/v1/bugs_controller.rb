module V1
  class BugsController < ApplicationController
    before_action :set_application_token

    def show
      @bug = Bug.filter(params[:number], @application_token)
    end

    def create
      @bug = Bug.new(bug_params)

      if @bug.push_to_worker
        render json: { number: @bug.number }, status: :created
      else
        respond_with(@bug.errors.full_messages)
      end
    end

    def count
      count = Bug.count_by_application(@application_token)
      render json: { count: count }, status: :ok
    end

    private

    def bug_params
      permitted_fields = [:status, :priority, state_attributes: %i(memory storage device os)]
      params.require(:bug).permit(permitted_fields).merge(application_token: @application_token)
    end

    def set_application_token
      @application_token = request.headers['x-application-token']
      respond_with('Application token is missing') unless @application_token
    end
  end
end
