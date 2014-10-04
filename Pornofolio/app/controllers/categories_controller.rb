class CategoriesController < ApplicationController

  def index
    @categories = Category.all.sort
  end

end
