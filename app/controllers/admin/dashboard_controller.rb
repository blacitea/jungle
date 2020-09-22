class Admin::DashboardController < Admin::BaseController

#  http_basic_authenticate_with name: ENV["ADMIN_ID"], password: ENV["ADMIN_PW"]

  def show
    @category_count = Category.count
    @product_count = Product.count
    @sale_count = Sale.count
  end
end
