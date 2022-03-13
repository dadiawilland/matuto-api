class CreateOnboardingAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :onboarding_answers do |t|
      t.integer :onboarding_option_id, null:false
      t.integer :user_id, null:false

      t.timestamps
    end
  end
end
