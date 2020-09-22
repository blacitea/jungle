class Admin::SalesController < Admin::BaseController

  # http_basic_authenticate_with name: ENV["ADMIN_ID"], password: ENV["ADMIN_PW"]

  def index
    @sales = Sale.all.order("starts_on")
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    if @sale.save
      redirect_to [:admin, :sales], notice: 'Sale created!'
    else
      render :new
    end
  end

  private

  def sale_params
    params.require(:sale).permit(:name, :starts_on, :ends_on, :percent_off)
  end
end
