require 'net/http'

class ProxyController < ActionController::Base
    # GET requests
    def show
        url = params[:url]

        #response = Net::HTTP.get(URI.parse(url))

        respond_to do |format|
            format.html { render html: url }
        end
    end

    # POST requests
    def create
    end
end