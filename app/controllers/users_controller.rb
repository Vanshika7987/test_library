class UsersController <ApplicationController
  def index 
    @users = User.all 
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(student_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(student_params)
      redirect_to users_path()
    else
      render edit
    end
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
  private
  def student_params
    params.require(:user).permit(:name, :role, :phone_number)
  end
end
