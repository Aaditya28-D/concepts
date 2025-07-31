-- WHERE ..=(subquery)
--return exactly one value to compare directly with that value 


--example 
--show the title and rental_rate of films that have the maximum rental rate in the database
SELECT
    title,
    rental_rate
FROM
    film
WHERE
    rental_rate = (
        SELECT
            MAX(rental_rate)
        FROM
            film
    );

--WHERE subquery (=) practice quesiton 1
-- list the title and rental_rate of films that have the minimum rental rate in the database
SELECT
    title,
    rental_rate
FROM
    film
WHERE
    rental_rate = (
        SELECT
            MIN(rental_rate)
        FROM
            film
    );


-- WHERE subquery (=) practice question 2
-- find the first name and last name of the customer who made the highest single payment 
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
            payment
        WHERE 
            amount=(
                SELECT
                    MAX(amount)
                FROM
                    payment

        )
    );

--list the title of all films that are in the most common language(i.e the language with the most films)

SELECT
    title
FROM
    film
WHERE
    language_id=(
        SELECT
            language_id
        FROM
            film
        GROUP BY
            language_id
        ORDER BY 
            COUNT(film_id) DESC
        LIMIT 1

    );

--WHERE (=) subquery practice question 4
-- show the first_name and last_name of the staff member who handled the most rentals
SELECT
    first_name,
    last_name
FROM
    staff
WHERE
    staff_id=(
        SELECT
            staff.staff_id
        FROM
            staff
            JOIN rental ON staff.staff_id=rental.staff_id
            GROUP BY staff.staff_id
            ORDER BY COUNT(rental.rental_id) DESC
            LIMIT 1
    );

-- WHERE = subquery practice question 5 of 10
-- show the title and length of all films that have the maximum length in the database 
SELECT
    title,
    length
FROM
    film
WHERE length=(
    SELECT
        MAX(length)
    FROM
        film
);

-- WHERE = subquery practice question 6 of 10
-- find the first_name and last_name of the customer who has made the largest total payment across all time
SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    customer_id=(
        SELECT
            customer_id
        FROM
            payment
        GROUP BY
            customer_id
        ORDER BY
            SUM(amount) DESC
        LIMIT 1
    );

-- WHERE = subquery practice questions 7
--show the title and replacement_cost of all films that have the highest replacement cost
SELECT
    title,
    replacement_cost
FROM
    film
WHERE
    replacement_cost=(
        SELECT
            MAX(replacement_cost)
        FROM
            film
    );

--WHERE = subquery practice question 8 
-- find the name of the ategory that has the least number of films assigned to it 
SELECT
    name
FROM
    category
WHERE
    category_id=(
        SELECT
            category_id
        FROM
            film_category
        GROUP BY
            category_id
        ORDER BY COUNT(film_id) ASC
        LIMIT 1
    );

-- WHERE = subquery practice question 9 
--find the city name that has the highest number of customers living in it
SELECT
    city
FROM
    city
WHERE
    city_id=(
        SELECT
            city_id
        FROM
            address
            JOIN customer ON address.address_id=customer.address_id
        GROUP BY
            city_id
        ORDER BY
            COUNT(customer_id) DESC
        LIMIT 1
    );


--WHERE =subquery practice question 10
--find the name of the country that has the most cities in the database 
SELECT
    country
FROM
    country
WHERE
    country_id=(
        SELECT
            country_id
        FROM
            city
        GROUP BY
            country_id
        ORDER BY
            COUNT(city_id) DESC
        LIMIT 1
    );
