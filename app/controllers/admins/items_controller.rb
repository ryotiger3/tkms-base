class Admins::ItemsController < Admins::ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
     if @item.save
          flash[:success] = "itemが正常に作成されました"
          redirect_to root_path
     else
          flash.now[:danger] = "itemが正常に作成されませんでした"
          render :new
     end
  end

    private
    
    def item_params
      params.require(:item).permit(:name, :price, :description, :category_id, :shipping_days_id, :image).merge(admin_id: current_admin.id)
    end
end
