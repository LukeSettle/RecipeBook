class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    binding.pry
    new_recipe_path
  end
end