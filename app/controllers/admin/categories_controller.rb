class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.order(:id).all
  end

  def new
    @category = Category.new
  end

end
