require "test_helper"
require 'net/http'
require 'json'
require_relative '../../lib/latest_stock_price/latest_stock_price'

class LatestStockPriceTest < ActionDispatch::IntegrationTest
    def setup
    # Mocking the API URL
    @api_url = 'https://latest-stock-price.p.rapidapi.com/'

    # Common headers for the request
    @headers = {
        'x-rapidapi-host' => 'latest-stock-price.p.rapidapi.com',
        'x-rapidapi-key' => 'aa68fee7e1mshb82e11a9d6fd048p1825c9jsn5d07cf694aea'
    }
    end

    def test_price
        symbol = 'ZOMA.NS'
        result = StockPrice::LatestStockPrice.price(symbol)
        assert_equal "ZOMA.NS", result[0]["Symbol"]
    end

    def test_prices
        symbols = 'ZOMA.NS,TATADVRA.NS'
        result = StockPrice::LatestStockPrice.prices(symbols)
        assert_equal "ZOMA.NS", result[0]["Symbol"]
        assert_equal "TATADVRA.NS", result[1]["Symbol"]
    end

    def test_price_all
        result = StockPrice::LatestStockPrice.price_all
        assert_equal "ZOMA.NS", result[0]["Symbol"]
        assert_equal "TATADVRA.NS", result[1]["Symbol"]
    end
end