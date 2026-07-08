class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    if user_signed_in? && current_user.respond_to?(:locale)
      I18n.locale = current_user.locale || I18n.default_locale
    else
      I18n.locale = I18n.default_locale
    end
  end
end
