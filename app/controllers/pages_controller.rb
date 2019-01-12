class PagesController < ApplicationController
  def top
    @micropost = current_user.microposts.build if logged_in?
  end
end
