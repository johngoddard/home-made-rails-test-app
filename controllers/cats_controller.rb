require_relative 'application_controller'

class CatsController < ApplicationController

  def index
    current_user
    @cats = Cat.all
    if @current_user
      render :index
    else
      redirect_to ('http://localhost:3000/session/new')
    end
  end

  def new
    current_user
    @cat = Cat.new
    render :new
  end

  def create
    current_user

    @cat = Cat.new(name: params["cat"]["name"], owner_id: params["cat"]["owner_id"].to_i)
    if current_user.nil?
      redirect_to (new_session_url)
    elsif @cat.save
      puts("cat saved")
      redirect_to (just_logged_in_url)
    else
      render :new
    end
  end

  private

  def new_session_url
    "http://localhost:#{@port}/session/new"
  end

  def just_logged_in_url
    "http://localhost:#{@port}/cats"
  end

end
