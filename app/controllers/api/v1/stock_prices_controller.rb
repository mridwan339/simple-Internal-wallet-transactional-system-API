require_relative '../../../../lib/latest_stock_price/latest_stock_price'

class Api::V1::StockPricesController < ApplicationController
    def price
        symbol = params[:symbol]
        price_data = StockPrice::LatestStockPrice.price(symbol)
        render json: price_data
    rescue => e
        render json: { error: e.message }, status: :unprocessable_entity
    end

    def prices
        symbols = params[:symbols]
        prices_data = StockPrice::LatestStockPrice.prices(symbols)
        render json: prices_data
    rescue => e
        render json: { error: e.message }, status: :unprocessable_entity
    end

    def price_all
        all_prices = StockPrice::LatestStockPrice.price_all
        render json: all_prices
    rescue => e
        render json: { error: e.message }, status: :unprocessable_entity
    end
end