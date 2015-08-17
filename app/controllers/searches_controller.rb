class SearchesController < ApplicationController
  
  def index
    @search = Search.new
    gon.google_geocoder = ENV['google_geocoder']
  end
  
  def create
    @ll = search_params['ll']
    @query = search_params['query']
    @near = search_params['near']

    if @near != ""
      @venues = Search.request_near(@query, @near)
    elsif @ll != ""
      @venues = Search.request_ll(@query, @ll)
    end

    if @venues == "error message"
      @venues = [] # will return sad toast
    else
      @google_map_locs = Search.get_google_locations(@venues)
      respond_to do |format|
        format.html {render :index}
        format.js
      end
    end
  end
  
  private
  
  def search_params
    params.require(:search).permit(:query, :ll, :near, :random_fact)
  end
end
