class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :ensure_current_user, only: [:edit, :update]
  
  def index
    @items = Item.all.order(created_at: "DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
    render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    if @pitem.user_id == current_user.id
     @item.destroy
    end
    redirect_to root_path
  end

    private
    def item_params
      params.require(:product).permit(:name, :price, :description, :category_id, :shipping_days_id, :image).merge(user_id: current_user.id)
    end

    def set_item
      @item = Item.find(params[:id])
    end

    def ensure_current_user
      if @item.user_id != current_user.id || @item.purchase_history.presence
        redirect_to action: :index
      end
    end
end
