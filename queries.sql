-- 1. Simple Queries
-- 1.1. Get all information from the customers table
SELECT * FROM customers;

-- 1.2. Get the first name, last name, and email of all customers
SELECT first_name, last_name, email FROM customers;

-- 1.3. Check the total service usage in each booking (result from trigger)
SELECT booking_id, total_service_usage FROM bookings;

-- 1.4. Check the salary of each employee (result from trigger)
SELECT employee_id, first_name, last_name, salary FROM employees;

-- 2. Conditional Queries
-- 2.1. Get information for the customer with customer_id = 1
SELECT * FROM customers WHERE customer_id = 1;

-- 2.2. Get all rooms with a price above 100
SELECT * FROM rooms WHERE price_per_night > 100;

-- 3. Queries with Calculations
-- 3.1. Calculate the total quantity of services used
SELECT SUM(quantity) FROM service_usage;

-- 3.2. Calculate the total revenue from services
SELECT SUM(total_price) FROM service_usage;

-- 4. Queries with GROUP BY
-- 4.1. Calculate total revenue by service type
SELECT service_id, SUM(total_price) AS total_revenue
FROM service_usage
GROUP BY service_id;

-- 4.2. Count the number of bookings by each customer
SELECT customer_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY customer_id;

-- 5. JOIN Queries
-- 5.1. Get information on all bookings along with customer details
SELECT b.booking_id, b.check_in_date, b.check_out_date, c.first_name, c.last_name
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id;

-- 5.2. Get information on services used in each booking
SELECT b.booking_id, s.service_name, su.quantity, su.total_price
FROM service_usage su
JOIN services s ON su.service_id = s.service_id
JOIN bookings b ON su.booking_id = b.booking_id;

-- 6. Subqueries
-- 6.1. Get customer information for the customer with the highest total booking value
SELECT * FROM customers
WHERE customer_id = (
    SELECT customer_id
    FROM bookings
    GROUP BY customer_id
    ORDER BY SUM(total_price) DESC
    LIMIT 1
);

-- 6.2. Get information on the most-used service
SELECT * FROM services
WHERE service_id = (
    SELECT service_id
    FROM service_usage
    GROUP BY service_id
    ORDER BY SUM(quantity) DESC
    LIMIT 1
);
