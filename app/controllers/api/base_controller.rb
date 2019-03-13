module Api
	class BaseController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from DataFinders::Exceptions::DataFetchingFailure do |e|
      error(404, e.message)
    end

    def error(status = 500, message="Server Error")
      render json: {success: false, code: status, message: message, payload: {}}, status: status and return
    end

    def success(data=nil, message="SUCCESS")
      data = JSON.parse render_to_string if data.nil?
      render json: {success: true, code: 200 , message: message, payload: data}, status: '200' and return
    end

    def render_404
      error(404, "Resource not found")
    end
	end
end