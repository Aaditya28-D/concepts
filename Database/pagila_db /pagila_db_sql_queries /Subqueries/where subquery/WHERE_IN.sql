
-- WHERE CLAUSE SUBQUERY 
---its a subquery used to filter rows from the main query
--the result of the subquery helps decide which rows to keep 

-- example
-- find all films that are currently in stock inventory 
--(the film table doesnt know which films are in stock)
--(but the inventory table does - it has film_ids) 

--the subquery runs first it gets all film ids in inventory
--the main query then filters film rows, only show films whose films id is in that list 
-- keywords (IN, =, EXISTS, =(SELECT MAX(..)))

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM inventory);

-- WHERE subquery practice question 1
--list the title and film_id. of all films that are currently available inventory
SELECT film_id, title
FROM film
WHERE film.film_id IN (
    SELECT film_id
    FROM inventory
);

--WHERE subuery practice question 2 
--list the first_name and last name of all customers who have made at least one payment
SELECT first_name, last_name
FROM customer 
WHERE customer_id IN (SELECT
customer_id
FROM payment);

--WHERE subquery practice question 3
-- list the title of all films that have been rented at least once
SELECT title
FROM film
WHERE film_id IN (SELECT
film_id
FROM inventory
JOIN rental ON inventory.inventory_id=rental.inventory_id
);

--WHERE subquery practice questions 4 
-- list the first_name, last_name of customers who rented a film in store 1
SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    customer_id IN (
        SELECT
            customer_id
            FROM
                rental
                JOIN inventory ON rental.inventory_id=inventory.inventory_id
                JOIN store ON inventory.store_id=store.store_id 
            WHERE
                store.store_id=1
    );


--WHERE subquery practice question 5 
-- list the title of all films that were rented by customer who are from the district 'California'
SELECT
    title
FROM
    film
WHERE
    film_id IN (
        SELECT
            inventory.film_id
        FROM
            inventory
            JOIN rental ON inventory.inventory_id=rental.inventory_id
            JOIN customer ON rental.customer_id=customer.customer_id
            JOIN address ON customer.address_id=address.address_id
        WHERE 
            address.district = 'California'
    );


-- WHERE NOT IN
--WHEN YOU want to exclude certain row based on another set of data 
--Its the opposite of IN
-- there should not by any null value in subquery . then the query fails and returns nothing

--EXAMPLE : list the title of all films that have never been rented
SELECT
    title
FROM
    film
WHERE
    film_id NOT IN (
        SELECT
            inventory.film_id
        FROM
            inventory
            JOIN rental ON inventory.inventory_id=rental.inventory_id
            WHERE inventory.film_id IS NOT NULL
    );
