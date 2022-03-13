class CreateOnboardingSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :onboarding_surveys do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
