-- 1. List all customers who live in Texas (use JOINs) 
SELECT first_name, last_name
FROM customer
INNER JOIN address 
ON customer.address_id = address.address_id
WHERE address.district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name 
SELECT payment.amount, customer.first_name, customer.last_name 
FROM payment 
INNER JOIN customer 
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries) 
SELECT customer.first_name, customer.last_name
FROM customer 
WHERE customer_id in(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id 
	HAVING SUM(amount) > 175
);

-- 4. List all customers that live in Nepal (use the city table)
SELECT * 
from customer
INNER JOIN address 
ON customer.address_id = address.address_id
INNER JOIN city 
ON address.city_id = city.city_id
INNER JOIN country 
ON city.country_id = country.country_id
WHERE country = 'Nepal'; 

-- 5. Which staff member had the most transactions? 
SELECT MAX(new_table.num)
FROM(
	SELECT COUNT(staff_id) AS num
	FROM payment 
	GROUP BY staff_id) new_table;


-- 6. How many movies of each rating are there?
SELECT rating, COUNT(rating) AS total_films
FROM film
GROUP BY rating;


-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT customer_id
FROM payment
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment
	WHERE amount > 6.99
);

	--Another way to get this without subquery and getting the name using a Join
SELECT first_name, last_name, payment.amount 
FROM customer 
INNER JOIN payment 
ON customer.customer_id = payment.customer_id 
WHERE payment.amount > 6.99;

-- 8. How many free rentals did our stores give away?
SELECT COUNT(amount) as free_rentals
FROM payment
GROUP BY amount
HAVING amount = 0.00
