class SearchController < ApplicationController
  def index
    @query = Item.ransack(params[:q])
    @items = @query.result(distinct: true)
  end
end
