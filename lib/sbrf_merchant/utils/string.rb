module SbrfMerchant
  module Utils
    module String
      def self.camel_case_lower(string)
        string.split('_').inject('') do |buffer, e|
          buffer << (buffer.empty? ? e : e.capitalize!)
        end
      end
    end
  end
end
