class Partner < ApplicationRecord
    validates :email, format: URI::MailTo::EMAIL_REGEXP
end
