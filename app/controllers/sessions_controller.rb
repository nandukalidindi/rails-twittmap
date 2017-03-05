require 'pry'

class SessionsController < ApplicationController
  def setup
    strategy = request.env['omniauth.strategy']
    render :text => "Setup complete.", status: 404
  end

  def create
    binding.pry

    redirect_to '/', status: 302
  end
end
