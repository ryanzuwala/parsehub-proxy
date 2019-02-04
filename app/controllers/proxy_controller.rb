require 'net/http'

class ProxyController < ActionController::Base
    # GET requests
    def show
        url_param = params[:url]
        url_param.gsub!('http:/', 'http://')
        url_param.gsub!('https:/', 'https://')

        #response = Net::HTTP.get(URI.parse(url))
        url = URI.parse(url_param)
        #url = URI.parse("http://www.google.com/")
        req = Net::HTTP::Get.new(url.to_s)
        res = Net::HTTP.start(url.host, url.port) { |http|
            http.request(req)
        }

        respond_to do |format|
            format.html { render html: res.body.html_safe }
        end
    end

    # POST requests
    def create
    end
end