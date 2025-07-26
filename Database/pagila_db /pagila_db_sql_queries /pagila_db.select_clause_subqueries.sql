-- display each customers name along with the total amount they have spent on rentals
SELECT c.customer_id, c.first_name, c.last_name, 
    (
        SELECT SUM(p.amount)
        FROM payment p
        WHERE p.customer_id = c.customer_id ) AS total_spent
FROM customer c;

--display each title along with the count of how many times it has been rented
SELECT f.film_id, f.title,
    (
        SELECT count(rental_id)
        FROM rental r 
        JOIN inventory i ON r.inventory_id=i.inventory_id
        WHERE i.film_id = f.film_id
    ) as rental_count
FROM film f;


--list each customer's name along with the average amount they've paid per rental


SELECT c.customer_id, c.first_name, c.last_name,
    (
        SELECT AVG(p.amount)
        FROM payment p
        WHERE c.customer_id=p.customer_id
    ) as avg_amount
FROM customer c;



--identify each customer's most frequently rented film category
SELECT c.customer_id, c.first_name, c.last_name,
    (
        SELECT cy.name
        FROM category cy 
        JOIN film_category fc ON cy.category_id = fc.category_id
        JOIN inventory i ON fc.film_id = i.film_id 
        JOIN rental r ON i.inventory_id=r.inventory_id
        WHERE r.customer_id=c.customer_id
        GROUP BY (cy.name)
        ORDER BY (COUNT(*)) DESC
        LIMIT 1
    )
FROM customer c;

--list each customer's name along with the totla number of unique films they have rented more than once
SELECT c.customer_id, c.first_name, c.last_name,    
    (
        SELECT COUNT(*)
        FROM (
            SELECT film_id
            FROM inventory i 
            JOIN rental r ON i.inventory_id=r.inventory_id
            WHERE r.customer_id = c.customer_id
            GROUP BY film_id
            HAVING count(film_id)>1
        )as sub
    ) AS films_rented_more_than_once
FROM customer c;


-- list each customer along with the total number of different films they have rented
SELECT c.customer_id,
    c.first_name,
    c.last_name,
    (
        SELECT COUNT(DISTINCT i.film_id)
        FROM rental r
        JOIN inventory i ON r.inventory_id = i.inventory_id
        WHERE c.customer_id = r.customer_id
    )
FROM customer c;



--list each film's title along with the name of the store that has the most copies of that film in inventory 
SELECT 
    f.film_id, 
    f.title,
    (
        SELECT s.store_id
        FROM inventory i
        JOIN store s ON i.store_id = s.store_id
        WHERE i.film_id = f.film_id
        GROUP BY s.store_id
        ORDER BY COUNT(i.inventory_id) DESC
        LIMIT 1
    ) AS store_with_most_copies
FROM 
    film f;
