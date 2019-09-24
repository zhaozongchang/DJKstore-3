class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  layout "admin"

  def index
    @products = Product.all.order("position ASC")
  end

  def new
    @product = Product.new
    @photo = @product.photos.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      if params[:photos] != nil
        params[:photos]["avatar"].each do |a|
          @photo = @product.photos.create(:avatar => a)
        end
      end
    redirect_to admin_products_path
  else
    render :new
   end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if params[:photos] != nil
      @product.photos.destroy_all            # 如果有新参数传过来，就删掉原来的图，以新的为准
      params[:photos]['avatar'].each do |a|
        @picture = @product.photos.create(:avatar => a)
      end
   @product.update(product_params)
    redirect_to admin_products_path
    elsif @product.update(produt_params)
      redirect_to admin_products_path
  else
    render :edit
   end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
  end

  def move_up
     @product = Product.find(params[:id])
     @product.move_higher
     redirect_to :back
   end

   def move_down
     @product = Product.find(params[:id])
     @product.move_lower
     redirect_to :back
   end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image)
  end
end
