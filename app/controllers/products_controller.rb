class ProductsController < ApplicationController
  before_action :validate_search_key, only: [:search]
  impressionist :actions => [:index,:show]
  def index
    @products = Product.all.order("position ASC")
  end

  def show
    @product = Product.find(params[:id])
    impressionist(@product)
    @photos = @product.photos.all
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
    current_cart.add_product_to_cart(@product)
    flash[:notice] = "你已成功将#{@product.title}加入购物车"
  else
    flash[:warning] = "你的购物车中已有此商品"
  end
    redirect_to :back

  end

  def search
   if @query_string.present?
     search_result = Product.ransack(@search_criteria).result(:distinct => true)
     @products = search_result.paginate(:page => params[:page], :per_page => 5 )
   end
 end

 def fresh
   @products = Product.where(:category_id => 1)
 end

 def food
   @products = Product.where(:category_id => 2)
 end

 def men
   @products = Product.where(:category_id => 3)
 end

 def women
   @products = Product.where(:category_id => 4)
 end

 def beautiful
   @products = Product.where(:category_id => 5)
 end

 def books
   @products = Product.where(:category_id => 6)
 end

 def computer
   @products = Product.where(:category_id => 7)
 end

 def furniture
   @products = Product.where(:category_id => 8)
 end

 def favorite
    @product = Product.find(params[:id])
    current_user.favorite_products << @product
    flash[:notice] = "您已收藏商品"
    redirect_to :back
  end

  def unfavorite
    @product = Product.find(params[:id])
    current_user.favorite_products.delete(@product)
    flash[:notice] = "您已取消收藏商品"
    redirect_to :back
  end

 protected

 def validate_search_key
   @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
   @search_criteria = search_criteria(@query_string)
 end

 def search_criteria(query_string)
   { :title_cont => query_string }
 end

end
