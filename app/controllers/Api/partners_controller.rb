module Api
	class PartnersController < Api::ApplicationController
		load_and_authorize_resource
		skip_before_action :doorkeeper_authorize!, only: %i[index]
		
		def search_fields = ['name', 'address', 'business_type', 'industry', 'application_status', 'contact_number', 'emails'].freeze

		def index
			search_params = search_fields & params.keys
			if search_params
				filtered_params = params.slice(*search_params)
				@partners = Partner.where(filtered_params.permit!)
				render json: { partners: @partners }
			else
				@partners = Partner.all
				render json: { partners: @partners }
			end
		end

		def create
			partner = Partner.new(partner_params)
			if partner.save
				render json: { partner: partner}
			else 
				render json: {error: partner.errors}, status: 500
			end
		end

		private

		def partner_params
			params.require(:partner).permit(:name, :address, :business_type, :industry, :application_status, :contact_number, :email)
		end
	end
end