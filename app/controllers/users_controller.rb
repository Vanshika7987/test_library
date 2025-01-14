class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:state, :city]
  skip_after_action :verify_authorized, only: [:state, :city, :create, :new]
  before_action :set_user, only: %i[show edit update destroy]
  
  def index
    @users = User.all.page(params[:page])
    console
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(student_params)
    if @user.save
      redirect_to users_path, notice: 'user has been created'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(student_params)
      redirect_to users_path(@user), notice: 'user has been updated'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'user has been destroyed'
  end

  def state
    states = CS.states(params[:country])
    render json: { states:  states }
  end

  def city 
    cities = CS.cities(params[:state],params[:country])
    render json: { cities: cities } 
  end

  private

  def student_params
    params.require(:user).permit(:name, :role, :phone_number)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
