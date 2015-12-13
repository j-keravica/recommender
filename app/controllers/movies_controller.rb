class MoviesController < ApplicationController

  def index
    @movies = Movie.all.limit(250)
  end

  def train
    map ||= Som::Map.new(2, 1128, 100) #size, vector dimension, iterations
    map.train
    render :nothing => true
  end

end
