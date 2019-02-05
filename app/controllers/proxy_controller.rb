require 'net/http'

class ProxyController < ActionController::Base
    # GET requests
    def show
        response = build_http_client :get, params[:url]

        respond_to do |format|
            format.html { render html: response }
        end
    end

    # POST requests
    def create
    end

    private
    def build_http_client(method, url)
        url_param = params[:url]

        url_param.gsub!('http:/', 'http://')
        url_param.gsub!('https:/', 'https://')
        url_param.prepend "http://" unless url_param.start_with? /https?\:\/\//

        url = URI.parse(url_param)
        
        req = Net::HTTP::Get.new(url)
        req["User-Agent"] = request.headers["User-Agent"]

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = (url.scheme == "https")
        res = http.request(req)

        res.body.html_safe
    end

end