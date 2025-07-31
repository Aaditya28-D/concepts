--WHERE NOT IN subquery practice question 1
-- list the first_name, last_name, of customer who have never made any payment
SELECT
    first_name,
    last_name
FROM
    customer
WHERE customer_id  NOT IN(
    SELECT
        customer_id
    FROM
        payment
    WHERE customer_id IS NOT NULL
);

--question 2
--list the title of all films that are not in the comedy category 
SELECT
    title
FROM
    film
WHERE
    film_id NOT IN (
        SELECT
            film_category.film_id
        FROM
            film_category
            JOIN category ON film_category.category_id=category.category_id
        WHERE 
            category.name ='Comedy' 
            AND film_category.film_id IS NOT NULL
    );


SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    customer_id NOT IN (
        SELECT
            customer_id
        FROM
            rental
        WHERE
            customer_id IS NOT NULL
    );


