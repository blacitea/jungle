class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.order(:id).all
  end

end
