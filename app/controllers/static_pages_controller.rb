class StaticPagesController < ApplicationController
  def home
    if signed_in?
      redirect_to takes_path
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
