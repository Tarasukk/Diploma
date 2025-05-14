class RemoveExperimentalFeaturesOptInFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :experimental_features_opt_in, :boolean
  end
end
