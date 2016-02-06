class Api::V1::AgesController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    render json: Age.all
  end
end
