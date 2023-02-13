class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, if: :api_request_authorized?
  before_action :authenticate_user!

  def api_request_authorized?
    if request.headers["request-is-api"] &&  request.headers["request-is-api"] == "7d160f9c-6ac6-49f3-9a34-058a32b41015"
      return true
    else
      return false
    end
  end
  
end
