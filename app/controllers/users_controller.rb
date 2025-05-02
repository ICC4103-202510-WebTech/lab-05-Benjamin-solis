class UsersController < ApplicationController
  def index
    @users = User.all
    puts "DEBUG: Número de usuarios encontrados: #{@users.count}"
    @users = [] if @users.nil?
  end

  def show
    @user = User.find(params[:id])
  end
end