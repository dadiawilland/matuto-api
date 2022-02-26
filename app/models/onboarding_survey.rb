class OnboardingSurvey < ApplicationRecord
    has_many :onboarding_option, inverse_of: :onboarding_survey, autosave: true

    accepts_nested_attributes_for :onboarding_option
    validates :title, presence: true
end
