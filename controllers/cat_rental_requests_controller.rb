class CatRentalRequestsController < ApplicationController

  def index
    @rentals = CatRentalRequest.all
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

  def update
    if @rental.update(rental_params)
      redirect_to @rental
    else
      flash.now[:notice] = @rental.errors.full_messages
      @cats = Cat.all
      render :edit
    end
  end

  def create
    @rental = CatRentalRequest.new(rental_params)
    if @rental.save
      redirect_to @rental
    else
      flash.now[:notice] = @rental.errors.full_messages
      @cats = Cat.all
      render :new
    end
  end

  def destroy
  end

  def approve
    begin
      @rental.approve!
    rescue
      flash[:notice] = "Cannot approve this request!"
    end
    redirect_to @rental.cat
  end

  def deny
    @rental.deny!
    redirect_to @rental.cat
  end

  private
  def rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status, :lat, :long)
  end

  def get_rental
    @rental = CatRentalRequest.find_by_id(params[:id])
  end

end
