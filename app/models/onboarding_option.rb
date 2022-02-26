class OnboardingOption < ApplicationRecord
    has_many :onboarding_answer

    belongs_to :onboarding_survey

    validates :title, presence: true
    # validates :onboarding_survey_id, presence: true
end
