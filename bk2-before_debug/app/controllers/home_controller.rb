class HomeController < ApplicationController
	skip_before_action :authenticate_user!
  def top
  end

  def about
  end
end
