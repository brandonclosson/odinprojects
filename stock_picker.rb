def stock_picker(prices)
  present_price, max_gain, buy_day, sell_day, present_price, present_day = 0

  while prices.length > 0
    present_price = prices.shift
    prices.each_with_index do |price, i|
      if (present_price - price) > max_gain
        buy_day = present_day
        sell_day = present_day + 1 + i
        max_gain = present_price - price
      end
    end
    present_day += 1
  end

  puts "Buy on day #{buy_day}, Sell on day #{sell_day}, Total gain of #{max_gain}"

end

stock_picker([7, 4, 8, 12, 15, 3, 2, 12, 7])