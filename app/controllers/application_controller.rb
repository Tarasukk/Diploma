class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :authenticate_user!

  private

  def layout_by_resource
    if devise_controller?
      'auth'
    else
      'application'
    end
  end
end
