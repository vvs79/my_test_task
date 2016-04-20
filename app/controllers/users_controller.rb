class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_users, only: [:index, :order_by_login, :order_by_email, :order_by_fname, :order_by_lname]
  before_action :check_if_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
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

  def order_by_login
    @users = @search.result.paginate(page: params[:page] || 1, per_page: 10).order(login: :asc)
    render 'index'
  end

  def order_by_email
    @users = @search.result.paginate(page: params[:page] || 1, per_page: 10).order(email: :asc)
    render 'index'
  end

  def order_by_fname
    @users = @search.result.paginate(page: params[:page] || 1, per_page: 10).order(first_name: :asc)
    render 'index'
  end

  def order_by_lname
    @users = @search.result.paginate(page: params[:page] || 1, per_page: 10).order(last_name: :asc)
    render 'index'
  end

  private

  def get_users
    @users = User.all
    @search = @users.search(params[:q] || {})
  end

    def user_params
      params.require(:user).permit(:login, :first_name, :last_name, :email, :password, :avatar)
    end

end
