class OnboardingAnswer < ApplicationRecord
    belongs_to :user
    belongs_to :onboarding_option

    validates :onboarding_option_id, presence: true
    validates :user_id, presence: true
end
