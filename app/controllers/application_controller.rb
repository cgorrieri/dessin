class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  def after_update_path_for(resource)
    private_datas_user_path
  end

  def after_sign_in_path_for(resource)
    private_datas_user_path
  end
end
