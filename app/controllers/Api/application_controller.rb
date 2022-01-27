# app/controllers/api/application_controller.rb
module Api
  class ApplicationController < ActionController::API
    # equivalent of authenticate_user! on devise, but this one will check the oauth token
    before_action :doorkeeper_authorize! :set_headers

    def set_headers
      headers['Access-Control-Allow-Origin'] = 'http://0.0.0.0:9000'
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
      headers['Access-Control-Allow-Headers'] = '*,X-Requested-With,Content-Type,If-Modified-Since,If-None-Match'
      headers['Access-Control-Max-Age'] = '86400'
    end
    private

    # helper method to access the current user from the token
    def current_user
      @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
    end
  end
end