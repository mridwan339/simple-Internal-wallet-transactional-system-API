require 'net/http'
require 'json'

module StockPrice
    class LatestStockPrice
        API_URL = 'https://latest-stock-price.p.rapidapi.com/'

        def self.price(symbol)
            response = request("equities-search?Search=#{symbol}")
            parse_response(response)
        end

        def self.prices(symbols)
            response = request("equities-enhanced?Symbols=#{symbols}")
            parse_response(response)
        end

        def self.price_all
            response = request('equities')
            parse_response(response)
        end

        private

        def self.request(endpoint)
            uri = URI("#{API_URL}#{endpoint}")
            req = Net::HTTP::Get.new(uri)
            req['x-rapidapi-host'] = 'latest-stock-price.p.rapidapi.com'
            req['x-rapidapi-key'] = 'aa68fee7e1mshb82e11a9d6fd048p1825c9jsn5d07cf694aea'

            Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(req)
            end
        end

        def self.parse_response(response)
            begin
                parsed_response = JSON.parse(response.body)
                raise "Parsed response is nil" if parsed_response.nil?
                parsed_response
            rescue JSON::ParserError => e
                raise "Failed to parse JSON: #{e.message}"
            end
        end
    end
end