class Api::UsersController < Api::ApplicationController
  skip_before_action :doorkeeper_authorize!, only: %i[create index add_avatar]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :add_avatar]

  # TODO: add error handling and type handling

  def index
    search_fields = ['email', 'first_name', 'last_name', 'contact_number'].freeze
    search_params = search_fields & params.keys
    result = SearchAllService.new( search_params, params, User ).execute

		render json: {users: result}
  end

  def add_avatar
    @user.update!(avatar_id: params[:avatar_id])
    render json: @user
  end

  def create
    User.transaction do
      user = User.new(user_params)

      user.add_role(:normal)

      if user.save
        # create access token for the user, so the user won't need to login again after registration

        if params['payment_info']["name"] 
          payment_info = PaymentInfo.new(payment_info_params)
          payment_info.user_id = user.id
          #TODO: create credit card integer to date converter
          payment_info.date_expiration = Time.at(params['payment_info']['date_expiration'].to_i)
          if payment_info.save
            access_token = Doorkeeper::AccessToken.create(
              resource_owner_id: user.id,
              refresh_token: generate_refresh_token,
              expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
              scopes: ''
            )
    
            render(json: {
              user: {
                id: user.id,
                email: user.email,
                access_token: access_token.token,
                token_type: 'bearer',
                expires_in: access_token.expires_in,
                refresh_token: access_token.refresh_token,
                created_at: access_token.created_at.to_time.to_i
              },
              payment_info: {
                payment_type: payment_info.payment_type,
                name: payment_info.name,
                number: payment_info.number,
                cvv: payment_info.cvv,
                date_expiration: payment_info.date_expiration
              }
            })
          else 
            raise ActiveRecord::Rollback
            render(json: { error: user.errors.full_messages }, status: 422)
          end

        else 
          access_token = Doorkeeper::AccessToken.create(
            resource_owner_id: user.id,
            refresh_token: generate_refresh_token,
            expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
            scopes: ''
          )
  
          render(json: {
            user: {
              id: user.id,
              email: user.email,
              access_token: access_token.token,
              token_type: 'bearer',
              expires_in: access_token.expires_in,
              refresh_token: access_token.refresh_token,
              created_at: access_token.created_at.to_time.to_i
            }
          })
        end
      else
        render(json: { error: user.errors.full_messages }, status: 422)
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirm, :first_name, :last_name, :contact_number)
  end

  def search_params
  end

  def payment_info_params
    params.require(:payment_info).permit(:payment_type, :name, :number, :cvv, :date_expiration)
  end

  def set_user
    @user = User.find(params[:id])
 end

  def generate_refresh_token
    loop do
      # generate a random token string and return it, 
      # unless there is already another token with the same string
      token = SecureRandom.hex(32)
      break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
    end
  end 
end