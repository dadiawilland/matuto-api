class PaymentInfo < ApplicationRecord
    belongs_to :user, optional: true
end
