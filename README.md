# README

This is a Web service designed to act as an HTTP proxy. It passes along the User-Agent string in the request header, along with the form data payload in the case of a POST request.

Setup
------

* `rbenv install`

This will install Ruby version 2.6.1. If this version is unable to be found, you may need to update your ruby-build. (On Mac OSX, you would run `brew update && brew upgrade ruby-build`)

* `gem install bundler`
* `bundle install`

Running the web service locally
-------

`bundle exec rails s`

Use
-------

The local Rails development server should be listening on port 3000. Assuming port 3000, proxied URL requests are formed like so:

`http://localhost:3000/proxy/httpbin.org/get`

The desired URL is simply appended after the proxy directory.