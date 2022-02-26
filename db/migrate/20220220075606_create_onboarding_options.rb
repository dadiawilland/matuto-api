class CreateOnboardingOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :onboarding_options do |t|
      t.integer :onboarding_survey_id, null: false
      t.string :title, null: false

      t.timestamps
    end
  end
end
