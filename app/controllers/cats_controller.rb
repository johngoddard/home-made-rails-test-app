require_relative 'application_controller'

class CatsController < ApplicationController

  def index
    @cats = Cat.all
    if current_user
      render :index
    else
      redirect_to ('http://localhost:3000/session/new')
    end
  end

  def new
    if current_user
      @cat = Cat.new
      render :new
    else
      redirect_to (new_session_url)
    end
  end

  def create
    @cat = Cat.new(name: params["cat"]["name"], owner_id: params["cat"]["owner_id"].to_i)
    if current_user.nil?
      redirect_to (new_session_url)
    elsif @cat.save
      redirect_to (just_logged_in_url)
    else
      render :new
    end
  end

end
