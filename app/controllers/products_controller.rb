class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    #@products = current_user.products if user_signed_in?
    @products = current_user.products.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page]) if user_signed_in?
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to products_path
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path
  end

  def import
    Product.import(params[:file])
    redirect_to root_url, notice: "Products imported."
  end

  private
    def product_params
      params.require(:product).permit(:name, :description, :price)
    end

  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
