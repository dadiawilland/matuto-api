class Api::PaymentInfoController < Api::ApplicationController
  skip_before_action :doorkeeper_authorize!, only: %i[create index]

  def index

  end

  def create
    PaymentInfo.transaction do
      payment_info = PaymentInfo.new(payment_info_params)
      payment_info.date_expiration = Time.at(params['payment_info']['date_expiration'].to_i)

      if payment_info.save
        render(json: {
          payment_info: {
            user_id: payment_info.user_id,
            payment_type: payment_info.payment_type,
            name: payment_info.name,
            number: payment_info.number,
            cvv: payment_info.cvv,
            date_expiration: payment_info.date_expiration
          }
        })
      else 
        render(json: { error: payment_info.errors.full_messages }, status: 422)
      end
    end
  end

  private

  def payment_info_params
    params.require(:payment_info).permit(:payment_type, :name, :number, :cvv, :date_expiration, :user_id)
  end
end