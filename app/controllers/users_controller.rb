class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @users = User.all
    @search = @users.search(params[:q] || {})
    @users = @search.result.paginate(page: params[:page] || 1, per_page: 10).order(id: :desc)
  end

  def destroy
    @user = User.find(params[:id])
    UsersMailer.user_destroyed(@user).deliver_now
    @user.destroy
    redirect_to :back
  end

  def show
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'User not exist'
    redirect_to users_admin_index_path
  end

  def edit
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'User not exist'
    redirect_to users_admin_index_path
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      UsersMailer.user_edited(@user).deliver_now
      redirect_to users_admin_index_path
    else
      render 'edit'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # ItemsMailer.item_created(@item, user).deliver_now if user.id > 4000
      redirect_to users_admin_path(@user)
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:login, :first_name, :last_name, :email, :password, :avatar)
    end

end
