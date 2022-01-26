module Api
	class PartnersController < Api::ApplicationController
		load_and_authorize_resource
		skip_before_action :doorkeeper_authorize!, only: %i[index]

		def index
			@partners = Partner.all
			render json: { partners: @partners }
		end
	end
end