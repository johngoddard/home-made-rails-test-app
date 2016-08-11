class CatRentalRequestsController < ApplicationController

  def index
    @rentals = CatRentalRequest.all
    render :index
  end

  def new
    @cats = Cat.all
    @rental = CatRentalRequest.new(cat_id: params[:cat_id])
  end

  def show
  end

  def edit
    @cats = Cat.all
  end

  def create
    if current_user.nil?
      redirect_to (new_session_url)
    else
      @rental = CatRentalRequest.new(cat_id: params["cat_rental_request"]["cat_id"],
                                     user_id: current_user.id,
                                     start_date: params["cat_rental_request"]["start_date"],
                                     end_date: params["cat_rental_request"]["end_date"])
      if @rental.save
        redirect_to rentals_url
      else
        render :new
      end
    end
  end


  private
  def rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status, :lat, :long)
  end

  def rentals_url
    "http://localhost:#{@port}/cat_rental_requests"
  end

end
