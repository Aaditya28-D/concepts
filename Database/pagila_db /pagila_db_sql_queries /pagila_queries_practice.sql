-- first and last name of the customers 
SELECT first_name, last_name
FROM customer;

--show first name and last name of the customer of store 1
SELECT first_name, last_name
FROM customer
WHERE store_id=1;


-- show the first name, last name of all customers, sorted by last name.
SELECT first_name, last_name
FROM customer
ORDER BY last_name DESC;

--get a list of all unique districts where customers live 
SELECT DISTINCT district
FROM address;

-- count how many customers are in each store 
SELECT store_id, COUNT(*) AS customer_count
FROM customer
GROUP BY store_id;

-- show store ids that have more than 300 customers 
SELECT store_id, COUNT(*) AS customer_count
FROM customer
GROUP BY store_id
HAVING COUNT(*)>300;

-- list the number of customers per store, ordered from least to most 
SELECT store_id, COUNT(*) AS customer_count
FROM customer
GROUP BY store_id
ORDER BY customer_count ASC; 

-- list all customers from store 1, ordered by last name descending
SELECT first_name, last_name
FROM customer
WHERE store_id=1 
ORDER BY last_name DESC;

--show the number of customers per store where the store is not 2 and only include stores wht more than 300 customers. sort result by count descending
SELECT store_id, COUNT(*) AS customer_count
FROM customer
WHERE store_id !=2
GROUP BY store_id
HAVING COUNT(*) >300
ORDER BY customer_count DESC;


--practice tasks (set1)
-- show the title and release_year of all films relased in 2006
SELECT title, release_year
FROM film
WHERE release_year =2006;

--list the first_name and last_name of customers from store 2 sorted by first_name 
SELECT first_name, last_name
FROM customer
WHERE store_id=2
ORDER BY first_name;

--how many customers are there per store? show store_id and customer_count
SELECT store_id, COUNT(*) AS customer_count
FROM customer
GROUP BY store_id;

-- list only those stores that have more than 350 customers. show store_id and customer_count
SELECT store_id, COUNT(*) AS customer_count
FROM customer
GROUP BY store_id
HAVING COUNT(*)>350;

-- show all unique postal_code values from the address table 
SELECT DISTINCT postal_code
FROM address;


--practice set 2
-- list the first and last name of customers whose first name starts with "A" 
SELECT first_name, last_name
FROM customer
WHERE first_name LIKE 'A%';

--show the number of addesses per district, sorted in descending order of address count 
SELECT district, COUNT(*) AS address_count
FROM address
GROUP BY district
ORDER BY address_count DESC;

-- list the store_id and the number of rentals made from each store
SELECT inventory.store_id, COUNT(*) AS rental_count
FROM rental
JOIN inventory ON rental.inventory_id=inventory.inventory_id
GROUP BY inventory.store_id;


-- show all the unique film ratings in the film table
SELECT DISTINCT rating
FROM film;

-- find how many films are in each rating category (e.g., PG, G, R), but only show those ratings that have more than 200 films 
SELECT rating, COUNT(*) AS films_count
FROM film
GROUP BY rating
HAVING COUNT(*)>200;


--set 3
-- show the title and length of all films longer than 180 minutes, ordered by length in descending order
SELECT title, length
FROM film
WHERE length>180
ORDER BY length DESC;

-- list the district and number of customers liviing in each district. Only include districts with at least 5 customers.
SELECT district, COUNT(customer.customer_id) AS customer_count
FROM customer
JOIN address ON customer.address_id=address.address_id
GROUP BY district
HAVING COUNT(customer.customer_id)>5
ORDER BY customer_count DESC;

--show the top 5 films with the highest rental rates. Display title and rental rate
SELECT title, rental_rate
FROM film
ORDER BY rental_rate DESC
LIMIT 5;


--list each rating category and the averge film length in that category, rounded at 2 decimal places 
SELECT rating, Round(AVG(length), 2) AS average_film_length
FROM film
GROUP BY rating
ORDER BY average_film_length DESC;


-- get a list of unique city names where the stores are located
SELECT city.city, COUNT(store.store_id) AS store_count_per_city
FROM store
JOIN address ON store.address_id= address.address_id
JOIN city ON address.city_id=city.city_id
GROUP BY city.city
ORDER BY store_count_per_city DESC;


-- set 4
--list the title and replacement_cost of all films that cost more than $25 to replace, soreted by cost descending 
SELECT title, replacement_cost
FROM film
WHERE replacement_cost>25
ORDER BY replacement_cost DESC;

-- show the district and total number of stores in each district. only include districts with more than one store 
SELECT district, COUNT(store_id) AS store_count_per_district
FROM store
JOIN address ON store.address_id=address.address_id
GROUP BY district
HAVING COUNT(store_id)>1;

-- find the first_name, last_name and number of rentals made by each customer
SELECT first_name, last_name, COUNT(rental_id) AS rental_count_per_customer
FROM customer
JOIN rental ON customer.customer_id=rental.customer_id
GROUP BY customer.customer_id
HAVING COUNT(rental_id)>=20
ORDER BY rental_count_per_customer DESC;

--list the number of staff members per store, sorted by staff count descending
SELECT store.store_id, COUNT(staff.staff_id) AS staff_per_store
FROM store
JOIN staff ON store.store_id=staff.store_id
GROUP BY store.store_id
ORDER BY staff_per_store DESC;

--Display the number of films per language. show language. name and film count.
SELECT language.name, COUNT(film_id) AS films_per_language
FROM film
JOIN language ON film.language_id=language.language_id
GROUP BY language.name;


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