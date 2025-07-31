
-- WHERE (!=/<>) subqueries
-- both means not equal to 
--EXAMPLE: 
SELECT
    title
    rental_rate
FROM
    film
WHERE
    rental_rate <> (
        SELECT
            AVG(rental_rate)
        FROM
            film
    );


--!=/<> subquery - question 1
--list the first_name and last_name of customers whose total payment is not equal to the average total payment of all customers

SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    (
        SELECT
            SUM(amount)
        FROM
            payment
        WHERE 
            payment.customer_id=customer.customer_id

    ) <>(
        SELECT
            AVG(total_amount)
        FROM (
            SELECT
                customer_id,
                SUM(amount) AS total_amount
            FROM
                payment
            GROUP BY
                customer_id
        ) AS customer_totals
    );


-- !=/<>subquery-Question 2
-- list the title and rental_duration of all films whose rental_duration is not equal to the maximum rental duration across all films 

SELECT
    title,
    rental_duration
FROM
    film
WHERE
    rental_duration <>(
        SELECT
            MAX(rental_duration)
        FROM
            film
    );

-- list the first_name and last_name of all staff members who did not process the highest number of payments 

SELECT
    first_name,
    last_name
FROM
    staff
WHERE (
    SELECT
        COUNT(*)
    FROM
        payment
    WHERE
        payment.staff_id=staff.staff_id
)<>(
    SELECT
        MAX(payment_count)
    FROM
        (
            SELECT
                staff_id,
                COUNT(payment_id) AS payment_count
            FROM
                payment
            GROUP BY
            payment.staff_id
        ) AS total_payment_counts
);


--show the names of all categories that do NOT have the most films
SELECT
    category.name
FROM
    category
    JOIN film_category ON category.category_id=film_category.category_id
    GROUP BY
        category.category_id, category.name
    HAVING
        COUNT(film_category.film_id)<> (
            SELECT
                MAX(films_per_category)
            FROM (
                SELECT
                    category_id,
                    COUNT(film_id) AS films_per_category
                FROM
                    film_category
                GROUP BY
                    category_id
            ) AS total_films_per_category
        );