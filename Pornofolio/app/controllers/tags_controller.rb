class TagsController < ApplicationController
  def index
    @tags = Tag.order(:created_at => :desc)
    @categories = Category.all.sort
  end
end
