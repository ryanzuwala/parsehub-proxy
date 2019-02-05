
require 'net/http'

class HTTPProxyService
  def self.send(method, request, params)
    url_param = params[:url]

    # Ensure that escaped slashes in URI schemes are properly formed
    url_param.gsub!('http:/', 'http://')
    url_param.gsub!('https:/', 'https://')

    # Default to HTTP if no scheme was provided
    url_param.prepend "http://" unless url_param.start_with? /https?\:\/\//

    url = URI.parse(url_param)
    
    # Determine HTTP method to use
    if method == :post
        req = Net::HTTP::Post.new(url) 

        # Extract form data from parameters object, excluding Rails route data
        form_data_params = params.except(:controller, :action, :url)
        req.set_form_data form_data_params.permit(form_data_params.keys).to_h
    else
        req = Net::HTTP::Get.new(url) 
    end
    
    req["User-Agent"] = request.headers["User-Agent"]
    
    # Construct HTTP request and enable SSL if we are using HTTPS
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == "https")
    res = http.request(req)

    # Return response body
    res.body.html_safe
  end
end