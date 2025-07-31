
-- FROM Clause subquery 
--show each customers first name last name and how many payments they made 

SELECT first_name,
        last_name,
        (SELECT COUNT(*)
        FROM payment
        WHERE payment.customer_id=customer.customer_id) AS payment_count
FROM customer;

--for each film, show the following: title, rental_rate, the number of times that film has been rented 
SELECT film.title, film.rental_rate, COUNT(rental.rental_id) as rental_count
FROM film
JOIN inventory ON film.film_id=inventory.film_id
JOIN rental ON inventory.inventory_id=rental.inventory_id
GROUP BY film.film_id, film.title, film.rental_rate
ORDER BY title ASC;

SELECT film_id, title, rental_rate
FROM film;

SELECT COUNT(rental.rental_id) AS rental_count
FROM inventory
JOIN rental ON inventory.inventory_id=rental.inventory_id;

SELECT  title,
        rental_rate,
        (SELECT COUNT(rental.rental_id)
        FROM inventory
        JOIN rental ON inventory.inventory_id=rental.inventory_id
        WHERE inventory.film_id=film.film_id) AS rental_count
FROM film
ORDER BY title ASC;


--subquery practice question 2
-- for each customer, show first_name, last_name, the total amount they have paid across all their payments 
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS total_payment
FROM customer
JOIN payment ON customer.customer_id=payment.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total_payment DESC;

SELECT first_name,
        last_name,
        (SELECT SUM(amount)
        FROM payment
        WHERE payment.customer_id=customer.customer_id) AS total_payment
FROM customer
ORDER BY total_payment DESC;

-- Subquery Practice Question 3 
-- For each staff member, show first_name, last_name, the number of payments they have processed 
SELECT staff.first_name, staff.last_name, COUNT(payment.payment_id) AS total_payment_processed
FROM staff
JOIN payment ON staff.staff_id=payment.staff_id
GROUP BY staff.staff_id, staff.first_name, staff.last_name
ORDER BY total_payment_processed DESC;

SELECT first_name,
        last_name,
        (SELECT COUNT(payment.payment_id)
        FROM payment
        WHERE payment.staff_id=staff.staff_id) AS total_payment_processed
FROM staff
ORDER BY total_payment_processed DESC;

--subquery practice quesiton 4
-- for each category of film show category.name and the number of films that belong to that category
SELECT category.name AS category_name, COUNT(film.film_id) AS number_of_films_per_category
FROM category
JOIN film_category ON category.category_id=film_category.category_id
JOIN film ON film_category.film_id=film.film_id
GROUP BY category.category_id, category.name
ORDER BY number_of_films_per_category DESC;

SELECT name AS category_name,
        (SELECT COUNT(film.film_id)
        FROM film_category
        JOIN film ON film_category.film_id=film.film_id
        WHERE film_category.category_id=category.category_id) AS number_of_films_per_category
FROM category
ORDER BY number_of_films_per_category DESC;





