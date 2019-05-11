module SbrfMerchant
  module Utils
    module String
      ToCamelCase = lambda do |str|
        str.split('_').inject('') do |buffer, e|
          buffer << (buffer.empty? ? e : e.capitalize!)
        end
      end
    end
  end
end
