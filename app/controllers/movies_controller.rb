class MoviesController < ApplicationController
  def index
    @movies = ['Iron Man', 'Superman', 'Spider-Man', 'Remember the Titans']
  end
end
