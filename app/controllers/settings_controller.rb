class SettingsController < ApplicationController
  def index
  end

  def update_preferences
    if current_user.update(settings_params)
      redirect_to settings_path, notice: 'Налаштування оновлено'
    else
      flash[:alert] = 'Не вдалося оновити налаштування'
      redirect_back fallback_location: root_path
    end
  end

  private

  def settings_params
    params.require(:user).permit(:disable_emails, :auto_generate_title_page)
  end
end
