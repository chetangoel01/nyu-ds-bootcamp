-- Take-Home Assignment

-- TABLE INFO :
-- SALES – Date, Order_id, Item_id, Customer_id, Quantity, Revenue
-- ITEMS – Item_id, Item_name, price, department
-- CUSTOMERS- customer_id, first_name,last_name,Address

-- Pull total number of orders that were completed on 18th March 2023
SELECT COUNT(Order_id) FROM SALES WHERE Date = '2023-03-18';

-- Pull total number of orders that were completed on 18th March 2023 with the first name ‘John’ and last name Doe’
SELECT COUNT(Order_id) FROM SALES NATURAL JOIN CUSTOMERS WHERE Date = '2023-03-18' AND FIRST_NAME = 'John' AND LAST_NAME = 'Doe';

-- Pull total number of customers that purchased in January 2023 and the average amount spend per customer
SELECT COUNT(DISTINCT Customer_id), AVG(total) FROM (SELECT Customer_id, SUM(Revenue) total FROM SALES WHERE Date BETWEEN '2023-01-01' AND '2023-01-31' GROUP BY Customer_id) t;

-- Pull the departments that generated less than $600 in 2022
SELECT COUNT(DISTINCT Customer_id), AVG(total) FROM (SELECT Customer_id, SUM(Revenue) total FROM SALES WHERE Date BETWEEN '2023-01-01' AND '2023-01-31' GROUP BY Customer_id) t;

-- What is the most and least revenue we have generated by an order
SELECT department, SUM(Revenue) FROM SALES JOIN ITEMS ON SALES.Item_id = ITEMS.Item_id WHERE Date BETWEEN '2022-01-01' AND '2022-12-31' GROUP BY department HAVING SUM(Revenue) < 600;

-- What were the orders that were purchased in our most lucrative order
-- First, get the ID of the most lucrative order
SELECT MAX(order_rev), MIN(order_rev) FROM (SELECT Order_id, SUM(Revenue) order_rev FROM SALES GROUP BY Order_id) t;

-- Now get the items in that top order
SELECT s.Order_id, s.Item_id, i.Item_name, s.Quantity, s.Revenue FROM SALES s JOIN ITEMS i ON s.Item_id = i.Item_id WHERE s.Order_id = (SELECT Order_id FROM (SELECT Order_id, SUM(Revenue) FROM SALES GROUP BY Order_id ORDER BY SUM(Revenue) DESC LIMIT 1) t);