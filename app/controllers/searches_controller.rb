class SearchesController < ApplicationController

  def searche

    @model = "searche"
    @search_eselect = params[:search_eselect]
    @system_category  = params[:system_category]
    @level  = params[:level]
    @upper_limit_count  = params[:upper_limit_count]
    @play_genre  = params[:play_genre]
    @play_time  = params[:play_time]

    @records = Scenario.search_for(@search_eselect, @system_category, @level, @upper_limit_count, @play_genre, @play_time)
  end
end
