class LogincounterController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def main
  end
  def welcome
    if session[:user]
      @user = User.find_by(:username => session[:user])
    else
      redirect_to '/'
    end
  end
  def login
    username = params[:username]
    password = params[:password]
    @user = User.find_by(:username => username, :password => password)
    if @user
      @user.count += 1
      @user.save
      session[:user] = @user.username
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
      session[:user] = @user.username
      render :json => { :user_name => @user.username , :login_count => @user.count }
    end
  end
  def logout
    session[:user] = nil
    render 'main'
  end
  def clear
    User.delete_all()
    session[:user] = nil
    render 'main'
  end
end
