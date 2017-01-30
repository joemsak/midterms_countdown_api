require 'uri'
require 'net/http'

class ResponsesController < ApplicationController
  def show
    res = Net::HTTP.get_response(URI(params[:url]))
    render json: { status: res.code }
  end
end
