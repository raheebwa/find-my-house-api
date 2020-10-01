# frozen_string_literal: true

class AuthController < ApplicationController
  before_action :authorized, except: [:login]

  # LOGGING IN
  def login
    @user = User.find_by(username: params[:username])

    if @user&.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: [@user.id, @user.username], token: token }
    else
      render json: { error: 'Invalid username or password' }
    end
  end

  def profile
    render json: @user
  end
end
