class WelcomeController < ApplicationController
  def index
    flash[:notice] = "欢迎来到第九块商城"
  end 
end
