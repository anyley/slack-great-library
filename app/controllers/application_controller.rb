# require 'slim/smart'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

#  before_action :set_locale
  before_action :authenticate_user!

  def change_user
    user = User.find params[:id]
    sign_in(user)

    redirect_to :root
  end

  private
    def set_locale
      I18n.locale = :ru
    end

end
