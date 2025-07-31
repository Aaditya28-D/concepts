
--WHERE (EXISTS) subqueries updated next when the it is dynamic database (some times the data is there sometimes it is not)
-- Example: show customer who have made at least one payment 

SELECT
    first_name,
    last_name
FROM
    customer
WHERE EXISTS (
    SELECT 1
    FROM payment
    WHERE payment.customer_id = customer.customer_id
);


-- EXISTS subquery practice question 1
-- list the first_name and last_name of all customers who have made at least one payment 
SELECT
    first_name,
    last_name
FROM
    customer
WHERE
     EXISTS (
        SELECT
            1
        FROM
            payment
        WHERE
            payment.customer_id =customer.customer_id
    );


-- EXISTS subquery practice question 2
-- list the first_name and last_name of all staff members who have processed at least one payment 
SELECT
    first_name,
    last_name
FROM
    staff
WHERE 
    EXISTS (
        SELECT  1
        FROM 
            payment
        WHERE
            payment.staff_id=staff.staff_id
    );


-- EXists Subquery Practice question 3
-- list the title of all films that have been rented at least once 

SELECT
    title
FROM
    film
WHERE
    EXISTS (
        SELECT 1
        FROM 
        inventory
        JOIN rental ON inventory.inventory_id=rental.inventory_id
        WHERE inventory.film_id=film.film_id
    );

-- EXISTS SUBQUERY practice question 4 
-- list the first_name and last_name of all customers who have rented a film from store 1
SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    EXISTS (
        SELECT 1
        FROM
            rental
            JOIN staff ON rental.staff_id=staff.staff_id
            JOIN store ON staff.store_id=store.store_id
        WHERE  rental.customer_id=customer.customer_id AND store.store_id=1
    );

SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    EXISTS (
        SELECT 1
        FROM 
            inventory
            JOIN rental ON inventory.inventory_id=rental.inventory_id
            WHERE rental.customer_id=customer.customer_id AND inventory.store_id=1
    );


-- EXISTS Subquery practice question 5
-- list the title of all films that have been rented by customers living in the district california

SELECT
    title
FROM
    film
WHERE
    EXISTS (
        SELECT 1
        FROM
            address
            JOIN customer ON address.address_id=customer.address_id
            JOIN rental ON customer.customer_id=rental.customer_id
            JOIN inventory ON rental.inventory_id=inventory.inventory_id
        WHERE inventory.film_id=film.film_id AND address.district='California'
    );
