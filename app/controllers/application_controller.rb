class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def home
    if params[:user_id]
      @recipes = Recipe.where(user_id: params[:user_id])
    else
      @recipes = Recipe.all
    end

    @new_recipes = Recipe.last(3)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
