class OnboardingSurveysSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :onboarding_option

  def onboarding_option
     customized_onboarding_option
  end

  private

  def customized_onboarding_option
    customized_options = []
    self.object.onboarding_option.each do |option|
      customized_options.push(OnboardingOptionsSerializer.new(option))
    end

    customized_options
  end
end