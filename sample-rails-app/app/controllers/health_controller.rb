class HealthController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false
  
  def index
    render json: { status: "ok" }
  end
end 