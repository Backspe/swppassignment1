class LogincounterController < ApplicationController
  def main
  end
  def welcome
  end
  def login
    username = params[:username]
    password = params[:password]
    @user = User.find_by(:username => username, :password => password)
    if @user
      @user.count += 1
      @user.save
      render :json => { :user_name => @user.username , :login_count => @user.count }
    else
      render :json => { :error_code => -4 }
    end
  end
  def signup
    username = params[:username]
    password = params[:password]
    if username.length < 5 or username.length > 20 
      render :json => { :error_code => -1 }
    elsif password.length < 8 or password.length > 20 
      render :json => { :error_code => -2 }
    elsif User.find_by(:username => username)
      render :json => { :error_code => -3 }
    else
      @user = User.create( :username => username, :password => password, :count => 1 )
      render :json => { :user_name => @user.username , :login_count => @user.count }
    end
  end
  def clear
  end
end
