class Admin::BaseController < ApplicationController
  before_action :logged_in_user, :check_admin
end
