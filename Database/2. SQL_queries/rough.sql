SELECT * FROM customer;
SELECT * FROM inventory;
SELECT * FROM  rental;
SELECT * FROM film;
SELECT*FROM category;
SELECT * FROM film_category;

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE amount>2
);

-- find all customers who have rented a film more than three times.
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM rental GROUP BY customer_id
    HAVING count (rental_id)>3
);

SELECT first_name, last_name
FROM customer
WHERE EXISTS(
    SELECT
    1
    FROM rental
    GROUP BY customer_id
    HAVING count(rental_id)>3
);

--find all films that are longer than the average length of all films in the database
SELECT title
FROM film
WHERE length>(
    select avg(length) as avg_length
    FROM film
);

SELECT create_date FROM customer;
SELECT rental_date FROM rental;

--Identify all customers who have made at least one rental on the same day  they registered as a customer
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
WHERE EXISTS (
    SELECT 1
    FROM rental r
    WHERE r.customer_id = c.customer_id
    AND CAST (r.rental_date AS DATE) = c.create_date
);

--find films which have never been rented
SELECT f.film_id, f.title
FROM film f
WHERE NOT EXISTS(
    SELECT 1
    FROM inventory i
    JOIN rental r ON r.inventory_id = i.inventory_id
    WHERE i.film_id=f.film_id
);

--identify all customers who have not made any payments
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c 
WHERE NOT EXISTS(
    SELECT 1
    FROM payment p
    WHERE p.customer_id= c.customer_id

);

SELECT f.film_id, f.title
FROM film f
WHERE EXISTS(
    SELECT
    1
    FROM rental r
    JOIN customer c ON r.customer_id = c.customer_id
    JOIN inventory i ON i.inventory_id = r.inventory_id
    WHERE c.current_date> 2005-12-31 AND i.film_id =f.film_id
);

--find all films that have been rented out by at least one customer who registered after 2005
SELECT DISTINCT f.film_id, f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE EXISTS (
    SELECT
    1
    FROM rental r
    JOIN customer c ON r.customer_id = c.customer_id
    WHERE c.create_date > '2005-12-31' AND r.inventory_id=i.inventory_id
);

-- Identify all staff members who have processed a rental for the film 'Academy DInosaur'
SELECT DISTINCT s.staff_id, s.first_name, s.last_name
FROM staff s
WHERE EXISTS (
    SELECT 1
    FROM rental r 
    JOIN inventory i ON r.inventory_id=i.inventory_id 
    JOIN film f ON i.film_id=f.film_id 
    WHERE f.title ='ACADEMY DINOSAUR' AND r.staff_id=s.staff_id
);

--identify all alnguages in which at least one film has not been rented out
SELECT DISTINCT l.language_id, l.name
FROM language l
JOIN film f ON l.language_id = f.language_id
WHERE NOT EXISTS (
    SELECT 1
    FROM inventory i
    JOIN rental r ON i.inventory_id = r.inventory_id
    WHERE i.film_id=f.film_id
);

-- find all customers who have rented at least one film categorized as comedy 
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
WHERE EXISTS(
    SELECT 1
    FROM renal r
    JOIN inventory i ON r.inventory_id=i.inventory_id
    JOIN film_category fc ON i.film_id =fc.film_id
    JOIN category cy ON fc.category_id=cy.category_id
    WHERE cy.name ='Comedy' AND c.customer_id = r.customer_id
);

-- find all customer who have rented only films categorized as comedy
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c 
WHERE EXISTS (
    -- confirm at least one comedy rental exists
    SELECT 1
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film_category fc ON i.film_id =fc. film_id
    JOIN category cy ON fc.category_id = cy.category_id
    WHERE cy.name = 'Comedy' AND c.customer_id = r.customer_id
)
AND NOT EXISTS(
    -- check for any non-comedy rentals by the customer
    SELECT 1
    FROM rental r
    JOIN inventory i ON r.inventory_id =i.inventory_id
    JOIN film_category fc ON i.film_id = fc.film_id
    JOIN category cy ON fc.category_id = cy.category_id 
    WHERE cy.name <> 'Comedy' AND c.customer_id = r.customer_id
);