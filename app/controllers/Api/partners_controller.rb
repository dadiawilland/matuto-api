class Api::PartnersController < Api::ApplicationController
	load_and_authorize_resource
	# skip_before_action :doorkeeper_authorize!, only: %i[index]

	def index
		search_fields = ['name', 'address', 'business_type', 'industry', 'application_status', 'contact_number', 'email'].freeze
		search_params = search_fields & params.keys
		result = SearchAllService.new( search_params, params, Partner ).execute
		
		render json: {partners: result}
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