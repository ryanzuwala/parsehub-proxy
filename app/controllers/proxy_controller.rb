class ProxyController < ActionController::Base
  # Disable XSRF protection as this is a REST API
  protect_from_forgery with: :null_session

  # GET requests
  def show
    produce_response :get
  end

  # POST requests
  def create
    produce_response :post
  end

  private
  def produce_response(method)
    response = HTTPProxyService.send method, request, params

    respond_to do |format|
      format.html { render html: response }
    end
  end
end