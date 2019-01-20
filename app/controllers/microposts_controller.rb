class MicropostsController < ApplicationController

  before_action :logged_in_user, only:[:create, :destroy, :edit]
  before_action :correct_user, only:[:destroy, :edit]
  before_action :set_params, only:[:edit, :show, :update]

  def new
    @micropost = current_user.microposts.build if logged_in?
  end

  def edit
    @category_list = @micropost.categories.pluck(:name).join(",")
  end

  def update
    category_list = params[:category_list].split(",")
    if @micropost.update_attributes(micropost_params)
      @micropost.save_categories(category_list)
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def show
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    category_list = params[:category_list].split(",")
    if @micropost.save
      @micropost.save_categories(category_list)
      redirect_to root_path
    else
      render 'pages/top'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to request.referrer || root_path
  end

  private

    def set_params
      @micropost = Micropost.find(params[:id])
    end

    def micropost_params
      params.require(:micropost).permit(:content, :title, :category_list)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
