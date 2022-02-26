class BatchCreateOnboardingOptionsService
    attr_accessor :onboarding_survey_params, :onboarding_option_params

    def initialize(onboarding_survey_params, onboarding_option_params)
        @onboarding_survey_params = onboarding_survey_params
        @onboarding_option_params = onboarding_option_params
    end

    def execute
        OnboardingSurvey.transaction do
            onboarding_survey = OnboardingSurvey.new(onboarding_survey_params)

            if onboarding_survey.save
                # onboarding_survey.onboarding_option.create(onboarding_option_params)
                # OnboardingOption.transaction do
                #     onboarding_option_params.each do |onboarding_option|
                #         OnboardingOption.new(onboarding_survey_id: onboarding_survey.id, title: onboarding_option['title']).save!
                #     end
                #     onboarding_survey.onboarding_option.create!(onboarding_option_params)
                # end
                # binding.pry
                return onboarding_survey
                # return onboarding_survey if onboarding_survey.onboarding_option.count == onboarding_option_params.count
            end
            binding.pry
            raise ActiveRecord::Rollback
            return { error: 'test' }
        end
    end
end