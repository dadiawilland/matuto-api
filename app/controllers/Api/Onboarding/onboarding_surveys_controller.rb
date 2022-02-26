class Api::Onboarding::OnboardingSurveysController < Api::ApplicationController
  skip_before_action :doorkeeper_authorize!, only: %i[batch_create show update]
  before_action :set_onboarding_survey, only: [:show, :edit, :update, :destroy]

  def batch_create 
    request = onboarding_params
    OnboardingSurvey.transaction do
      onboarding_survey = OnboardingSurvey.new(request["survey"])
      if onboarding_survey.save!
        OnboardingOption.transaction do
          onboarding_survey.onboarding_option.create!(request["options"])
        end
        render(json: { onboarding_survey: onboarding_survey, onboarding_option: onboarding_survey.onboarding_option })
      else
        raise ActiveRecord::Rollback
        render(json: { error: onboarding_survey.errors.full_messages }, status: 422)
      end
    end
  end

  def show
    render(json: { onboarding_survey: @onboarding_survey, onboarding_option: @onboarding_survey.onboarding_option })
    # render(json: { error: @onboarding_survey.errors.full_messages }, status: 422)
  end

  def edit
  end

  def update
    # if @onboarding_survey.update(onboarding_params)
    #   render(json: { onboarding_survey: @onboarding_survey }) 
    # end
    binding.pry
    request = onboarding_params
    OnboardingSurvey.transaction do
      binding.pry
      if @onboarding_survey.update!(request["survey"])
        OnboardingOption.transaction do
          @onboarding_survey.onboarding_option.update!(request["options"])
        end
        render(json: { onboarding_survey: @onboarding_survey, onboarding_option: @onboarding_survey.onboarding_option })
      else
        raise ActiveRecord::Rollback
        render(json: { error: @onboarding_survey.errors.full_messages }, status: 422)
      end
    end
  end

  def destroy

  end

  private

  def set_onboarding_survey
    @onboarding_survey = OnboardingSurvey.find(params[:id])
    binding.pry
 end
  
  def onboarding_params
    params.require(:onboarding).permit(:survey => :title, :options => [:title])
  end
end