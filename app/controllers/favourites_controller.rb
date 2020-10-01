# frozen_string_literal: true

class FavouritesController < ApplicationController
  def index
    @favourite = Favourite.where('user_id = ?', params[:user_id])
    render json: @favourite
  end

  def create
    @favourite = current_user.favourites.create!(favourite_params)
    render json: @favourite
  end

  def destroy
    set_favourite
    @favourite.destroy
  end

  private

  def favourite_params
    params.permit(:house_id)
  end

  def set_favourite
    @favourite = Favourite.find(params[:id])
  end
end
