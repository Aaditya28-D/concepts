-- list the categories of films and the total number of rentals for each category 
-- where the total number of rentals is greater than 100, sorted by teh number of rentals in descending order 

SELECT cy.name,
    count(rental_id) as total_rental_count
FROM category cy
    JOIN film_category fc ON cy.category_id = fc.category_id
    JOIN inventory i ON fc.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY cy.name
HAVING count(rental_id) > 100
ORDER BY count(rental_id) DESC;

-- Find all stores and the total rvenue generated from rentals for each store,
-- only including stores that have generated more than $5000 in revenue, 
-- sorted by revenue in ascending order 

SELECT s.store_id,
    SUM(p.amount) as total_revenue
FROM store s
    JOIN inventory i ON s.store_id = i.store_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN payment p ON r.rental_id = p.rental_id
GROUP BY s.store_id
HAVING SUM(p.amount) > 5000
ORDER BY SUM(p.amount);


-- list each film and the number of times it was rented in the second quarter of 2022, 
-- only including films that were rented at least 10 times during this period, 
-- sorted by the number of rentals in descending order
SELECT f.title,
    COUNT(r.rental_id) AS rental_count
FROM film f
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_date >= '2022-04-01 00:00:00'
    AND r.rental_date < '2022-07-01 00:00:00'
GROUP BY f.title
HAVING COUNT(r.rental_id) >= 10
ORDER BY rental_count DESC;


--Identify the customer who has spent the most money on rentals overall. 
--Display the customer's ID, first name, last name, and the total amount they have spent.
SELECT c.customer_id,
    c.first_name,
    c.last_name,
    sum(amount)
FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY SUM(amount) DESC
LIMIT 1;

--Determine which categories of films have an average rental rate greater than $2 and were released in year 2006.
--list these categories along with their average rental rates, sorted by the average rental rate in desceding order.

SELECT cy.name,
    AVG(f.rental_rate) as avg_rental_rate
FROM category cy
    JOIN film_category fc ON cy.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
WHERE release_year=2006
GROUP BY cy.name
HAVING AVG(rental_rate)>2.00
ORDER BY avg_rental_rate DESC;


-- list the names of actors who have appreared in more than 15 films,
-- sorted by the nubmer of films they have appeared in descending order. 

SELECT a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fc.film_id) as films_count
FROM actor a
    JOIN film_actor fc ON a.actor_id = fc.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fc.film_id) > 15
ORDER BY films_count DESC;

-- Identify the stores that have not achieved any rentals in the month of July 2022.
-- List the store ID and the city where each store is located 

