class Api::OnboardingSurveysController < Api::ApplicationController
    skip_before_action :doorkeeper_authorize!, only: %i[batch_create]

    def batch_create 
        
        request = onboarding_params
        # onboarding_survey_params = {title: request["title"]}

        # result = BatchCreateOnboardingOptionsService.new(
        #     request["survey"],
        #     request["options"]
        # ).execute

        OnboardingSurvey.transaction do
            onboarding_survey = OnboardingSurvey.new(request["survey"])
            if onboarding_survey.save
                # onboarding_survey.onboarding_option.create(onboarding_option_params)
                # OnboardingOption.transaction do
                #     onboarding_option_params.each do |onboarding_option|
                #         OnboardingOption.new(onboarding_survey_id: onboarding_survey.id, title: onboarding_option['title']).save!
                #     end
                #     onboarding_survey.onboarding_option.create!(onboarding_option_params)
                # end
                # binding.pry
                binding.pry
                render(json: {onboarding: onboarding_survey})
                # return onboarding_survey if onboarding_survey.onboarding_option.count == onboarding_option_params.count
            end
            binding.pry
            raise ActiveRecord::Rollback
            # render { error: 'test' }
        end

        
    end

    private 
    
    def onboarding_params
        params.require(:onboarding).permit(:survey => :title, :options => [:title])
    end

    # def onboarding_option_params
    #     # params.require(:onboarding_survey).permit!
    #     params.require(:onboarding_survey).permit(:title)
    #     params.permit(:onboarding_option => [:title])
    # end
end