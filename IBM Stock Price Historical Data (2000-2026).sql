create database ibm;
use ibm;

CREATE TABLE stock_prices (
    stock_date DATE PRIMARY KEY,
    open_price DECIMAL(10, 2),
    high_price DECIMAL(10, 2),
    low_price DECIMAL(10, 2),
    close_price DECIMAL(10, 2),
    adj_close DECIMAL(10, 2),
    volume BIGINT
);

SELECT COUNT(*) FROM stock_prices 
   WHERE close_price IS NULL OR volume IS NULL;
   
   SELECT MIN(stock_date) AS start_date, MAX(stock_date) AS end_date FROM stock_prices;
   
   SELECT MAX(high_price) AS historical_max, MIN(low_price) AS historical_min 
   FROM stock_prices;
   
   SELECT stock_date, volume, close_price 
FROM stock_prices 
ORDER BY volume DESC 
LIMIT 10;

SELECT 
       stock_date,
       close_price,
       LAG(close_price, 1) OVER (ORDER BY stock_date) AS previous_close,
       ((close_price - LAG(close_price, 1) OVER (ORDER BY stock_date)) / LAG(close_price, 1) OVER (ORDER BY stock_date)) * 100 AS daily_return_percentage
   FROM stock_prices;
   
   SELECT 
    stock_date,
    close_price,
    AVG(close_price) OVER (
        ORDER BY stock_date 
        ROWS BETWEEN 19 PRECEDING AND CURRENT ROW
    ) AS sma_20
FROM stock_prices;

SELECT 
       EXTRACT(YEAR FROM stock_date) AS stock_year,
       AVG(close_price) AS average_close_price,
       SUM(volume) AS total_yearly_volume
   FROM stock_prices
   GROUP BY EXTRACT(YEAR FROM stock_date)
   ORDER BY stock_year;
