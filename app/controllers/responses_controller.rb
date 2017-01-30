class ResponsesController < ApplicationController
  def show
    render json: @response
  end
end
