class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SimpleCaptcha::ControllerHelpers

	def after_sign_in_path_for(resource)
  	home_path
	end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  private

    def set_cache_headers
      response.headers["Cache-Control"] = "no-cache, no-store"
    end
end
