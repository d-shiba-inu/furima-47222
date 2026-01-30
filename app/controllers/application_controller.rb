class ApplicationController < ActionController::Base
  before_action :basic_auth # Basic認証用
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def basic_auth # Basic認証用
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :lastname_full_letters, :firstname_full_letters, :lastname_kana,
                                             :firstname_kana, :birth_date])
  end
end
