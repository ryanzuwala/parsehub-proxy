class ProxyController < ActionController::Base
  # Disable XSRF protection as this is a REST API
  protect_from_forgery with: :null_session

  # GET requests
  def show
    response = HTTPProxyService.send :get, request, params

    respond_to do |format|
      format.html { render html: response }
    end
  end

  # POST requests
  def create
    response = HTTPProxyService.send :post, request, params

    respond_to do |format|
      format.html { render html: response }
    end
  end
end