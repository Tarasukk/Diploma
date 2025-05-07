module System
  class ApplicationController < ApplicationController
    before_action :authenticate_system_user!

    def authenticate_system_user!
      return if current_user&.admin?

      flash[:error] = 'Unauthorized system access'
      redirect_back(fallback_location: root_path)
    end
  end
end
