class Api::Onboarding::OnboardingSurveysController < Api::ApplicationController
  skip_before_action :doorkeeper_authorize!, only: %i[batch_create index show update]
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

  def index
    search_fields = ['title'].freeze
		search_params = search_fields & params.keys
		result = SearchAllService.new( search_params, params, OnboardingSurvey ).execute
		render json: result, each_serializer: OnboardingSurveysSerializer
  end

  def show
    render(json: { onboarding_survey: @onboarding_survey, onboarding_option: @onboarding_survey.onboarding_option })
  end

  def edit
  end

  def update
    request = onboarding_params
    OnboardingSurvey.transaction do
      if @onboarding_survey.update!(request["survey"])
        OnboardingOption.transaction do
          arr_id = @onboarding_survey.onboarding_option_ids
          request["options"].each do |option|
            if !option["id"]
              @onboarding_survey.onboarding_option.create!(option)
              next
            end
            if arr_id.include?(option["id"])
              @onboarding_survey.onboarding_option.find(option["id"]).update!(option)
              arr_id.delete(option["id"])
            end
          end
          arr_id.each do |id|
            @onboarding_survey.onboarding_option.destroy(id)
          end
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
 end
  
  def onboarding_params
    params.require(:onboarding).permit(:survey => :title, :options => [:title, :id])
  end
end