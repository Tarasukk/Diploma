class AddExperimentalFeaturesOptInToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :experimental_features_opt_in, :boolean
  end
end
