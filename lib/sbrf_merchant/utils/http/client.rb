# frozen_string_literal: true

require 'net/http'

module SbrfMerchant
  module Utils
    module Http
      class Client
        def call(uri, params)
          request = ::Net::HTTP::Post.new(uri)
          request.set_form_data(params)

          ::Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(request)
          end
        end
      end
    end
  end
end
