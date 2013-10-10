require "httparty"
require "json"
require "ostruct"
require "rodzilla/version"
require "rodzilla/resource/base"
require "rodzilla/resource/product"
require "rodzilla/resource/bugzilla"

module Rodzilla
  class WebService

    attr_accessor :base_url, :username, :password, :format 

    def initialize(base_url, username, password)
      @base_url = base_url
      @username = username
      @password = password
      @format   = :json
    end

    def bugzilla_resource(resource)
      raise Rodzilla::ResourceNotFoundError, "Error: #{resource} not found." unless Rodzilla::Resource.constants.include?(resource.to_sym)
      klass = Object.module_eval("Rodzilla::Resource::#{resource}").new(@base_url, @username, @password, @format)
    end

    def products
      bugzilla_resource('Product')
    end

    def bugzilla
      bugzilla_resource('Bugzilla')
    end


  end
end
