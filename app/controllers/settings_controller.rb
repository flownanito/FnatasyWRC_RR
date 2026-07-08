class SettingsController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    if current_user.update(settings_params)
      # Store the user's selected locale so it persists
      I18n.locale = current_user.locale
      redirect_to settings_path, notice: I18n.t('settings.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def settings_params
    params.require(:user).permit(:locale, :theme)
  end
end
